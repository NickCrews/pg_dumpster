use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::{Path, PathBuf};

use anyhow::{Context, Result, bail};

use crate::table_read::Format;
use crate::test_utils::case::TestCase;

const UPDATE_ENV_VAR: &str = "UPDATE_SNAPSHOTS";
const MAX_DIFFS_SHOWN: usize = 20;
const DEFAULT_ID_COLUMN: &str = "id";

pub struct Snapshot {
    path: PathBuf,
    id_column: String,
    format: Format,
}

impl Snapshot {
    pub fn new(test_case: &TestCase, name: &str) -> Self {
        let path = test_case.dir.join("snapshots").join(name);
        let format = if name.ends_with(".csv") {
            Format::Csv
        } else if name.ends_with(".parquet") {
            Format::Parquet
        } else if name.ends_with(".tsv") {
            Format::TsvRaw
        } else {
            panic!("cannot infer snapshot format from name: {}", name);
        };
        Self {
            path,
            id_column: DEFAULT_ID_COLUMN.to_string(),
            format,
        }
    }

    pub fn with_id_column(mut self, id_column: &str) -> Self {
        self.id_column = id_column.to_string();
        self
    }

    pub fn assert_matches(&self, actual_path: &Path, format: Format) -> Result<()> {
        let actual = read_actual(actual_path, format).with_context(|| {
            format!("failed to read actual output at {}", actual_path.display())
        })?;

        if update_mode_enabled() {
            write_snapshot(&self.path, &actual, &self.id_column, self.format)?;
            eprintln!("[snapshot] updated {}", self.path.display());
            return Ok(());
        }

        if !self.path.exists() {
            write_snapshot(&self.path, &actual, &self.id_column, self.format)?;
            bail!(
                "snapshot created at {} — review its contents and commit it. \
                 Subsequent runs will verify against it. \
                 Set {}=1 to regenerate.",
                self.path.display(),
                UPDATE_ENV_VAR,
            );
        }

        let expected = read_actual(&self.path, self.format)
            .with_context(|| format!("failed to read snapshot at {}", self.path.display()))?;

        let diffs = compare(&expected, &actual, &self.id_column);
        if diffs.is_empty() {
            return Ok(());
        }
        bail!("{}", format_diffs(&self.path, &diffs));
    }
}

fn update_mode_enabled() -> bool {
    match std::env::var(UPDATE_ENV_VAR) {
        Ok(v) => !v.is_empty() && v != "0" && v.to_ascii_lowercase() != "false",
        Err(_) => false,
    }
}

struct Table {
    columns: Vec<String>,
    /// One entry per row. Each inner vec has exactly `columns.len()` entries.
    /// `None` is a SQL NULL, `Some("")` is a literal empty string.
    rows: Vec<Vec<Option<String>>>,
}

impl Table {
    fn column_index(&self, name: &str) -> Option<usize> {
        self.columns.iter().position(|c| c == name)
    }
}

fn read_actual(path: &Path, format: Format) -> Result<Table> {
    match format {
        Format::Csv => read_csv(path),
        Format::Parquet => read_parquet(path),
        Format::TsvRaw => read_tsv_raw(path),
    }
}

/// Parse a CSV file, distinguishing quoted empty fields (`""`, → `Some("")`)
/// from unquoted empty fields (→ `None`, treated as SQL NULL). This is
/// essential for validating that our CSV writer preserves null vs empty
/// string, which tools like DuckDB rely on.
fn read_csv(path: &Path) -> Result<Table> {
    let bytes = fs::read(path).with_context(|| format!("failed to read {}", path.display()))?;
    let text = std::str::from_utf8(&bytes)
        .with_context(|| format!("CSV at {} is not valid UTF-8", path.display()))?;
    let mut all = parse_csv(text)
        .with_context(|| format!("failed to parse CSV at {}", path.display()))?;
    if all.is_empty() {
        bail!("CSV at {} is empty", path.display());
    }
    let header = all.remove(0);
    let columns: Vec<String> = header
        .into_iter()
        .map(|f| f.unwrap_or_default())
        .collect();
    for (i, row) in all.iter().enumerate() {
        if row.len() != columns.len() {
            bail!(
                "CSV row {} has {} fields but header has {}",
                i,
                row.len(),
                columns.len(),
            );
        }
    }
    Ok(Table { columns, rows: all })
}

fn parse_csv(text: &str) -> Result<Vec<Vec<Option<String>>>> {
    let mut rows: Vec<Vec<Option<String>>> = Vec::new();
    let mut row: Vec<Option<String>> = Vec::new();
    let mut field = String::new();
    let mut in_quotes = false;
    let mut was_quoted = false;

    let mut chars = text.chars().peekable();
    while let Some(c) = chars.next() {
        if in_quotes {
            if c == '"' {
                if chars.peek() == Some(&'"') {
                    chars.next();
                    field.push('"');
                } else {
                    in_quotes = false;
                }
            } else {
                field.push(c);
            }
            continue;
        }
        match c {
            ',' => {
                let val = if was_quoted || !field.is_empty() {
                    Some(std::mem::take(&mut field))
                } else {
                    None
                };
                row.push(val);
                was_quoted = false;
            }
            '\r' | '\n' => {
                if c == '\r' && chars.peek() == Some(&'\n') {
                    chars.next();
                }
                if was_quoted || !field.is_empty() || !row.is_empty() {
                    let val = if was_quoted || !field.is_empty() {
                        Some(std::mem::take(&mut field))
                    } else {
                        None
                    };
                    row.push(val);
                    rows.push(std::mem::take(&mut row));
                }
                was_quoted = false;
            }
            '"' if field.is_empty() && !was_quoted => {
                in_quotes = true;
                was_quoted = true;
            }
            _ => field.push(c),
        }
    }
    if in_quotes {
        bail!("unterminated quoted field at end of CSV");
    }
    if was_quoted || !field.is_empty() || !row.is_empty() {
        let val = if was_quoted || !field.is_empty() {
            Some(field)
        } else {
            None
        };
        row.push(val);
        rows.push(row);
    }
    Ok(rows)
}

/// Read a raw-postgres-COPY TSV, where `\N` is the null marker and all other
/// fields are literal text (with `\n`, `\t`, `\\`, etc. as two-char
/// sequences left as-is — we do not attempt to unescape them, just round-trip).
fn read_tsv_raw(path: &Path) -> Result<Table> {
    let text = fs::read_to_string(path)
        .with_context(|| format!("failed to read TSV at {}", path.display()))?;
    let mut lines = text.split('\n');
    let header_line = lines
        .next()
        .ok_or_else(|| anyhow::anyhow!("TSV at {} is empty", path.display()))?;
    let columns: Vec<String> = header_line.split('\t').map(|s| s.to_string()).collect();
    let mut rows = Vec::new();
    for (i, line) in lines.enumerate() {
        if line.is_empty() {
            continue;
        }
        let row: Vec<Option<String>> = line
            .split('\t')
            .map(|s| if s == "\\N" { None } else { Some(s.to_string()) })
            .collect();
        if row.len() != columns.len() {
            bail!(
                "TSV row {} has {} fields but header has {}",
                i,
                row.len(),
                columns.len(),
            );
        }
        rows.push(row);
    }
    Ok(Table { columns, rows })
}

fn read_parquet(path: &Path) -> Result<Table> {
    use arrow::array::{Array, StringArray};
    use arrow::compute::cast;
    use arrow::datatypes::DataType;
    use parquet::arrow::arrow_reader::ParquetRecordBatchReaderBuilder;

    let file = fs::File::open(path)
        .with_context(|| format!("failed to open parquet at {}", path.display()))?;
    let builder =
        ParquetRecordBatchReaderBuilder::try_new(file).context("failed to build parquet reader")?;
    let schema = builder.schema().clone();
    let columns: Vec<String> = schema
        .fields()
        .iter()
        .map(|f| f.name().to_string())
        .collect();

    let reader = builder.build().context("failed to open parquet reader")?;
    let mut rows: Vec<Vec<Option<String>>> = Vec::new();
    for batch_result in reader {
        let batch = batch_result.context("failed to read parquet batch")?;
        let string_cols: Vec<StringArray> = (0..batch.num_columns())
            .map(|i| -> Result<StringArray> {
                let arr = batch.column(i);
                let casted = cast(arr, &DataType::Utf8)
                    .with_context(|| format!("failed to cast column {} to Utf8", columns[i]))?;
                let s = casted
                    .as_any()
                    .downcast_ref::<StringArray>()
                    .ok_or_else(|| anyhow::anyhow!("cast to Utf8 did not produce StringArray"))?
                    .clone();
                Ok(s)
            })
            .collect::<Result<_>>()?;
        for r in 0..batch.num_rows() {
            let row: Vec<Option<String>> = string_cols
                .iter()
                .map(|col| {
                    if col.is_null(r) {
                        None
                    } else {
                        Some(col.value(r).to_string())
                    }
                })
                .collect();
            rows.push(row);
        }
    }
    Ok(Table { columns, rows })
}

enum Diff {
    MissingColumn(String),
    ExtraColumn(String),
    MissingIdColumnInExpected(String),
    MissingIdColumnInActual(String),
    DuplicateIdInExpected(String),
    DuplicateIdInActual(String),
    MissingRow {
        id: String,
    },
    ExtraRow {
        id: String,
    },
    CellMismatch {
        id: String,
        column: String,
        expected: Option<String>,
        actual: Option<String>,
    },
}

fn compare(expected: &Table, actual: &Table, id_column: &str) -> Vec<Diff> {
    let mut diffs = Vec::new();

    let exp_cols: HashSet<&str> = expected.columns.iter().map(String::as_str).collect();
    let act_cols: HashSet<&str> = actual.columns.iter().map(String::as_str).collect();
    for c in &expected.columns {
        if !act_cols.contains(c.as_str()) {
            diffs.push(Diff::MissingColumn(c.clone()));
        }
    }
    for c in &actual.columns {
        if !exp_cols.contains(c.as_str()) {
            diffs.push(Diff::ExtraColumn(c.clone()));
        }
    }

    let exp_id_idx = match expected.column_index(id_column) {
        Some(i) => i,
        None => {
            diffs.push(Diff::MissingIdColumnInExpected(id_column.to_string()));
            return diffs;
        }
    };
    let act_id_idx = match actual.column_index(id_column) {
        Some(i) => i,
        None => {
            diffs.push(Diff::MissingIdColumnInActual(id_column.to_string()));
            return diffs;
        }
    };

    let exp_by_id = index_by_id(&expected.rows, exp_id_idx, &mut diffs, true);
    let act_by_id = index_by_id(&actual.rows, act_id_idx, &mut diffs, false);

    let common_columns: Vec<(String, usize, usize)> = expected
        .columns
        .iter()
        .filter_map(|c| {
            actual
                .column_index(c)
                .and_then(|ai| expected.column_index(c).map(|ei| (c.clone(), ei, ai)))
        })
        .collect();

    let mut exp_ids: Vec<&String> = exp_by_id.keys().collect();
    exp_ids.sort();
    for id in &exp_ids {
        let exp_row = exp_by_id.get(*id).unwrap();
        match act_by_id.get(*id) {
            None => diffs.push(Diff::MissingRow { id: (*id).clone() }),
            Some(act_row) => {
                for (col, ei, ai) in &common_columns {
                    let e = exp_row.get(*ei).cloned().unwrap_or(None);
                    let a = act_row.get(*ai).cloned().unwrap_or(None);
                    if e != a {
                        diffs.push(Diff::CellMismatch {
                            id: (*id).clone(),
                            column: col.clone(),
                            expected: e,
                            actual: a,
                        });
                    }
                }
            }
        }
    }

    let mut extra_ids: Vec<&String> = act_by_id
        .keys()
        .filter(|k| !exp_by_id.contains_key(*k))
        .collect();
    extra_ids.sort();
    for id in extra_ids {
        diffs.push(Diff::ExtraRow { id: id.clone() });
    }

    diffs
}

fn index_by_id<'a>(
    rows: &'a [Vec<Option<String>>],
    id_idx: usize,
    diffs: &mut Vec<Diff>,
    is_expected: bool,
) -> HashMap<String, &'a Vec<Option<String>>> {
    let mut out: HashMap<String, &Vec<Option<String>>> = HashMap::new();
    let mut duplicates: HashSet<String> = HashSet::new();
    for row in rows {
        let id = match row.get(id_idx).and_then(|c| c.clone()) {
            Some(id) => id,
            None => continue,
        };
        if out.insert(id.clone(), row).is_some() {
            duplicates.insert(id);
        }
    }
    let mut dups: Vec<String> = duplicates.into_iter().collect();
    dups.sort();
    for id in dups {
        if is_expected {
            diffs.push(Diff::DuplicateIdInExpected(id));
        } else {
            diffs.push(Diff::DuplicateIdInActual(id));
        }
    }
    out
}

fn format_diffs(path: &Path, diffs: &[Diff]) -> String {
    let mut out = String::new();
    out.push_str(&format!(
        "snapshot mismatch: {}\n{} diff(s) found:\n",
        path.display(),
        diffs.len(),
    ));
    for d in diffs.iter().take(MAX_DIFFS_SHOWN) {
        match d {
            Diff::MissingColumn(c) => {
                out.push_str(&format!("  column missing from actual: {c}\n"));
            }
            Diff::ExtraColumn(c) => {
                out.push_str(&format!("  unexpected extra column in actual: {c}\n"));
            }
            Diff::MissingIdColumnInExpected(c) => {
                out.push_str(&format!(
                    "  snapshot is missing the id column '{c}'; cannot match rows\n"
                ));
            }
            Diff::MissingIdColumnInActual(c) => {
                out.push_str(&format!(
                    "  actual output is missing the id column '{c}'; cannot match rows\n"
                ));
            }
            Diff::DuplicateIdInExpected(id) => {
                out.push_str(&format!(
                    "  duplicate id in snapshot: {id} (only the last occurrence is compared)\n"
                ));
            }
            Diff::DuplicateIdInActual(id) => {
                out.push_str(&format!(
                    "  duplicate id in actual output: {id} (only the last occurrence is compared)\n"
                ));
            }
            Diff::MissingRow { id } => {
                out.push_str(&format!("  row missing from actual: id={id}\n"));
            }
            Diff::ExtraRow { id } => {
                out.push_str(&format!("  unexpected extra row in actual: id={id}\n"));
            }
            Diff::CellMismatch {
                id,
                column,
                expected,
                actual,
            } => {
                out.push_str(&format!(
                    "  cell mismatch at id={id} column={column}:\n    expected: {}\n    actual:   {}\n",
                    fmt_opt(expected),
                    fmt_opt(actual),
                ));
            }
        }
    }
    if diffs.len() > MAX_DIFFS_SHOWN {
        out.push_str(&format!(
            "  ... and {} more diff(s) not shown\n",
            diffs.len() - MAX_DIFFS_SHOWN,
        ));
    }
    out.push_str(&format!(
        "Re-run with `{UPDATE_ENV_VAR}=1 cargo test ...` to overwrite the snapshot.\n",
    ));
    out
}

fn fmt_opt(v: &Option<String>) -> String {
    match v {
        None => "<null>".to_string(),
        Some(s) => format!("{:?}", s),
    }
}

fn write_snapshot(path: &Path, table: &Table, id_column: &str, format: Format) -> Result<()> {
    let id_idx = table.column_index(id_column).ok_or_else(|| {
        anyhow::anyhow!(
            "cannot write snapshot: id column '{}' not found in columns {:?}",
            id_column,
            table.columns,
        )
    })?;

    let mut indices: Vec<usize> = (0..table.rows.len()).collect();
    indices.sort_by(|&a, &b| {
        let av = table.rows[a].get(id_idx).and_then(|c| c.as_ref());
        let bv = table.rows[b].get(id_idx).and_then(|c| c.as_ref());
        av.cmp(&bv)
    });

    if let Some(parent) = path.parent() {
        fs::create_dir_all(parent)
            .with_context(|| format!("failed to create snapshot directory {}", parent.display()))?;
    }

    let mut file = fs::File::create(path)
        .with_context(|| format!("failed to open snapshot for writing: {}", path.display()))?;
    match format {
        Format::Csv => write_csv_snapshot(&mut file, table, &indices)?,
        Format::TsvRaw => write_tsv_snapshot(&mut file, table, &indices)?,
        Format::Parquet => panic!("writing parquet snapshots is not supported yet"),
    }
    Ok(())
}

fn write_csv_snapshot(
    out: &mut impl std::io::Write,
    table: &Table,
    indices: &[usize],
) -> Result<()> {
    write_csv_line(
        out,
        table.columns.iter().map(|c| Some(c.as_str())),
    )?;
    for &i in indices {
        write_csv_line(out, table.rows[i].iter().map(|v| v.as_deref()))?;
    }
    Ok(())
}

fn write_csv_line<'a, I: Iterator<Item = Option<&'a str>>>(
    out: &mut impl std::io::Write,
    fields: I,
) -> Result<()> {
    let mut first = true;
    for f in fields {
        if !first {
            out.write_all(b",")?;
        }
        first = false;
        if let Some(s) = f {
            write_csv_field(out, s)?;
        }
    }
    out.write_all(b"\n")?;
    Ok(())
}

fn write_csv_field(out: &mut impl std::io::Write, s: &str) -> Result<()> {
    let needs_quoting = s.is_empty()
        || s.bytes().any(|b| matches!(b, b'"' | b',' | b'\n' | b'\r'));
    if !needs_quoting {
        out.write_all(s.as_bytes())?;
        return Ok(());
    }
    out.write_all(b"\"")?;
    let bytes = s.as_bytes();
    let mut last = 0;
    for (i, b) in bytes.iter().enumerate() {
        if *b == b'"' {
            out.write_all(&bytes[last..=i])?;
            out.write_all(b"\"")?;
            last = i + 1;
        }
    }
    out.write_all(&bytes[last..])?;
    out.write_all(b"\"")?;
    Ok(())
}

fn write_tsv_snapshot(
    out: &mut impl std::io::Write,
    table: &Table,
    indices: &[usize],
) -> Result<()> {
    out.write_all(table.columns.join("\t").as_bytes())?;
    out.write_all(b"\n")?;
    for &i in indices {
        let row = &table.rows[i];
        let mut first = true;
        for v in row {
            if !first {
                out.write_all(b"\t")?;
            }
            first = false;
            match v {
                None => out.write_all(b"\\N")?,
                Some(s) => out.write_all(s.as_bytes())?,
            }
        }
        out.write_all(b"\n")?;
    }
    Ok(())
}
