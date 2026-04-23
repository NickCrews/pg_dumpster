use std::collections::{HashMap, HashSet};
use std::fs::File;
use std::io::{BufRead, BufReader, BufWriter, Read};
use std::path::PathBuf;
use std::sync::{Arc, OnceLock};

use anyhow::{Context, Result};
use clap::Parser;
use glob::Pattern;
use libpgdump::format::custom::write_dump;
use libpgdump::{Blob, Dump, ObjectType};
use pg_dumpster::reader::UnopenedReader;
use rayon::prelude::*;
use regex::Regex;

const ROW_PROGRESS_EVERY: usize = 1_000_000;

struct TableDataResult {
    bytes: Vec<u8>,
    rows_seen: usize,
    rows_kept: usize,
}

#[derive(Debug)]
enum EntryAction {
    Skip,
    ReadBlobs,
    ReadBytes,
    ReadTableData,
}

#[derive(Debug)]
#[allow(dead_code)]
enum EntryProcessed {
    Empty,
    Blobs(Vec<Blob>),
    Bytes(Vec<u8>),
    TableData {
        bytes: Vec<u8>,
        rows_seen: usize,
        rows_kept: usize,
    },
}

#[derive(Parser, Debug)]
#[command(author, version, about)]
struct Cli {
    #[arg(index = 1)]
    dump_loc: String,
    #[arg(index = 2)]
    output_dump: PathBuf,
    #[arg(long)]
    row_limit: Option<usize>,
    #[arg(long, value_parser = parse_row_sample)]
    row_sample: Option<f64>,
    #[arg(long)]
    table_pattern: Option<String>,
}

fn parse_row_sample(value: &str) -> std::result::Result<f64, String> {
    let parsed = value
        .parse::<f64>()
        .map_err(|_| format!("invalid row sample value: {value}"))?;
    if !parsed.is_finite() {
        return Err("row sample must be finite".to_string());
    }
    if !(0.0..=1.0).contains(&parsed) {
        return Err("row sample must be between 0.0 and 1.0".to_string());
    }
    Ok(parsed)
}

fn main() -> Result<()> {
    let cli = Cli::parse();
    run(cli)
}

fn run(cli: Cli) -> Result<()> {
    let table_pattern = cli
        .table_pattern
        .as_deref()
        .map(Pattern::new)
        .transpose()
        .context("invalid --table-pattern glob")?;

    let dump_loc = cli.dump_loc;
    let reader = UnopenedReader::new(dump_loc.clone())?.read_toc()?;
    let toc = Arc::new(reader.toc);
    let entries = toc.entries.to_vec();
    eprintln!("Loaded {} entries", entries.len());

    // Phase 1: decide what to do for each entry
    let mut include_ids = Vec::with_capacity(entries.len());
    let mut actions: Vec<(i32, EntryAction)> = Vec::with_capacity(entries.len());
    for (idx, entry) in entries.iter().enumerate() {
        let action = if entry.desc == ObjectType::TableData
            && !should_copy_table_data(entry.copy_stmt.as_deref(), table_pattern.as_ref())
        {
            eprintln!("  Skipping TABLE DATA entry (pattern mismatch)");
            EntryAction::Skip
        } else if entry.desc == ObjectType::Blobs {
            include_ids.push(entry.dump_id);
            EntryAction::ReadBlobs
        } else if entry.desc == ObjectType::TableData {
            include_ids.push(entry.dump_id);
            EntryAction::ReadTableData
        } else {
            include_ids.push(entry.dump_id);
            EntryAction::ReadBytes
        };
        let tag = entry.tag.as_deref().unwrap_or("<none>");
        eprintln!(
            "[{}/{}] planning entry {} dump_id={} with action {:?}",
            idx + 1,
            entries.len(),
            tag,
            entry.dump_id,
            action
        );
        actions.push((entry.dump_id, action));
    }

    // Phase 2: read and process in parallel
    let row_limit = cli.row_limit;
    let row_sample = cli.row_sample;
    let toc_for_workers = Arc::clone(&toc);
    let processed: Vec<(i32, EntryProcessed)> = actions
        .into_par_iter()
        .map(|(dump_id, action)| -> Result<(i32, EntryProcessed)> {
            let worker_unopened = UnopenedReader::new(dump_loc.clone())
                .with_context(|| format!("failed to open reader for entry {}", dump_id))?;
            let mut worker_reader = worker_unopened.use_toc(toc_for_workers.as_ref());
            let processed = match action {
                EntryAction::Skip => EntryProcessed::Empty,
                EntryAction::ReadBlobs => {
                    panic!("blobs aren't handled")
                }
                EntryAction::ReadBytes => match worker_reader
                    .open_data_reader(dump_id)
                    .with_context(|| format!("failed opening entry {}", dump_id))?
                {
                    None => EntryProcessed::Empty,
                    Some(mut r) => {
                        let mut bytes = Vec::new();
                        r.read_to_end(&mut bytes)
                            .with_context(|| format!("failed reading entry {}", dump_id))?;
                        EntryProcessed::Bytes(bytes)
                    }
                },
                EntryAction::ReadTableData => match worker_reader
                    .open_data_reader(dump_id)
                    .with_context(|| format!("failed opening entry {}", dump_id))?
                {
                    None => EntryProcessed::Empty,
                    Some(r) => {
                        let r = limit_rows_from_reader(r, row_limit, row_sample, dump_id)?;
                        eprintln!(
                            "Entry {}: kept {}/{} rows",
                            dump_id, r.rows_kept, r.rows_seen
                        );
                        EntryProcessed::TableData {
                            bytes: r.bytes,
                            rows_seen: r.rows_seen,
                            rows_kept: r.rows_kept,
                        }
                    }
                },
            };
            Ok((dump_id, processed))
        })
        .collect::<Result<_>>()?;

    // Phase 3: assemble
    let mut data: HashMap<i32, Vec<u8>> = HashMap::new();
    let mut blobs: HashMap<i32, Vec<Blob>> = HashMap::new();
    let _include_id_set: HashSet<i32> = include_ids.into_iter().collect();
    let mut total_rows_seen = 0usize;
    let mut total_rows_kept = 0usize;

    for (dump_id, entry) in processed {
        match entry {
            EntryProcessed::Empty => {}
            EntryProcessed::Blobs(items) => {
                blobs.insert(dump_id, items);
            }
            EntryProcessed::Bytes(bytes) => {
                data.insert(dump_id, bytes);
            }
            EntryProcessed::TableData {
                bytes,
                rows_seen,
                rows_kept,
            } => {
                data.insert(dump_id, bytes);
                total_rows_seen += rows_seen;
                total_rows_kept += rows_kept;
            }
        }
    }

    let dump = Dump {
        toc: Arc::unwrap_or_clone(toc),
        data,
        blobs,
    };

    let output = File::create(&cli.output_dump)
        .with_context(|| format!("failed to create output dump {}", cli.output_dump.display()))?;
    let mut writer = BufWriter::new(output);
    write_dump(&mut writer, &dump).context("failed to write mock dump")?;
    eprintln!(
        "Done. Wrote {} entries to {}. TABLE DATA kept {}/{} rows.",
        dump.toc.entries.len(),
        cli.output_dump.display(),
        total_rows_kept,
        total_rows_seen
    );
    Ok(())
}

fn limit_rows_from_reader<R: Read>(
    reader: R,
    row_limit: Option<usize>,
    row_sample: Option<f64>,
    dump_id: i32,
) -> Result<TableDataResult> {
    let mut reader = BufReader::new(reader);
    let mut out = Vec::new();
    let mut line = Vec::new();
    let mut rows_kept = 0usize;
    let mut rows_seen = 0usize;
    loop {
        line.clear();
        let bytes_read = reader
            .read_until(b'\n', &mut line)
            .context("failed while streaming table data")?;
        if bytes_read == 0 {
            break;
        }
        let mut end = line.len();
        if end > 0 && line[end - 1] == b'\n' {
            end -= 1;
        }
        if end > 0 && line[end - 1] == b'\r' {
            end -= 1;
        }
        if line[..end] == *b"\\." {
            break;
        }
        let keep_by_limit = row_limit.is_none_or(|limit| rows_kept < limit);
        let keep_by_sample =
            row_sample.is_none_or(|sample| should_keep_row(rows_seen, &line[..end], sample));
        if keep_by_limit && keep_by_sample {
            out.extend_from_slice(&line);
            rows_kept += 1;
        }
        rows_seen += 1;
        // Early exit: limit hit and no sample means we don't need to count remaining rows
        if row_sample.is_none() && row_limit.is_some_and(|limit| rows_kept >= limit) {
            break;
        }
        if rows_seen.is_multiple_of(ROW_PROGRESS_EVERY) {
            eprintln!(
                "Entry {} progress: seen {} rows, kept {} rows",
                dump_id, rows_seen, rows_kept
            );
        }
    }
    out.extend_from_slice(b"\\.\n");
    Ok(TableDataResult {
        bytes: out,
        rows_seen,
        rows_kept,
    })
}

fn should_keep_row(row_index: usize, row: &[u8], sample: f64) -> bool {
    if sample <= 0.0 {
        return false;
    }
    if sample >= 1.0 {
        return true;
    }
    let hash = hash_row(row_index, row);
    let unit = (hash as f64) / (u64::MAX as f64);
    unit < sample
}

fn hash_row(row_index: usize, row: &[u8]) -> u64 {
    let mut hash: u64 = 0xcbf29ce484222325;
    for byte in row_index.to_le_bytes() {
        hash ^= u64::from(byte);
        hash = hash.wrapping_mul(0x100000001b3);
    }
    for &byte in row {
        hash ^= u64::from(byte);
        hash = hash.wrapping_mul(0x100000001b3);
    }
    hash
}

fn should_copy_table_data(copy_stmt: Option<&str>, table_pattern: Option<&Pattern>) -> bool {
    let Some(table_pattern) = table_pattern else {
        return true;
    };
    let Some(table_name) = table_name_from_copy_stmt(copy_stmt) else {
        return true;
    };
    table_pattern.matches(&table_name)
}

fn table_name_from_copy_stmt(copy_stmt: Option<&str>) -> Option<String> {
    let stmt = copy_stmt?;
    static COPY_RE: OnceLock<Regex> = OnceLock::new();
    let re = COPY_RE.get_or_init(|| {
        Regex::new(r"(?i)^COPY\s+(.+?)\s*\(.*\)\s+FROM\s+stdin;?\s*$")
            .expect("copy regex must compile")
    });
    let captures = re.captures(stmt.trim())?;
    let raw = captures.get(1)?.as_str().trim();
    Some(raw.replace('"', ""))
}

#[cfg(test)]
mod tests {
    use std::fs;
    use std::path::PathBuf;

    use glob::Pattern;
    use tempfile::NamedTempFile;

    use super::{
        Cli, limit_rows_from_reader, run, should_copy_table_data, table_name_from_copy_stmt,
    };

    #[test]
    fn keeps_copy_terminator_after_truncation() {
        let input = b"1\n2\n3\n\\.\n";
        assert_eq!(
            limit_rows_from_reader(&input[..], Some(2), None, 42)
                .expect("limit rows should succeed")
                .bytes,
            b"1\n2\n\\.\n"
        );
    }

    #[test]
    fn supports_zero_rows() {
        let input = b"1\n2\n\\.\n";
        assert_eq!(
            limit_rows_from_reader(&input[..], Some(0), None, 42)
                .expect("limit rows should succeed")
                .bytes,
            b"\\.\n"
        );
    }

    #[test]
    fn supports_zero_percent_sample() {
        let input = b"1\n2\n\\.\n";
        assert_eq!(
            limit_rows_from_reader(&input[..], None, Some(0.0), 42)
                .expect("row sampling should succeed")
                .bytes,
            b"\\.\n"
        );
    }

    #[test]
    fn supports_full_percent_sample() {
        let input = b"1\n2\n\\.\n";
        assert_eq!(
            limit_rows_from_reader(&input[..], None, Some(1.0), 42)
                .expect("row sampling should succeed")
                .bytes,
            b"1\n2\n\\.\n"
        );
    }

    #[test]
    fn parses_table_name_from_copy_statement() {
        let stmt = r#"COPY disclosure.fitem_sched_a (id) FROM stdin;"#;
        assert_eq!(
            table_name_from_copy_stmt(Some(stmt)).expect("table name should parse"),
            "disclosure.fitem_sched_a"
        );
    }

    #[test]
    fn table_pattern_matches_expected_table() {
        let pattern = Pattern::new("*fitem_sched_a*").expect("pattern should compile");
        let stmt = r#"COPY disclosure.fitem_sched_a (id) FROM stdin;"#;
        assert!(should_copy_table_data(Some(stmt), Some(&pattern)));
    }

    #[test]
    fn table_pattern_filters_out_non_matching_table() {
        let pattern = Pattern::new("*fitem_sched_a*").expect("pattern should compile");
        let stmt = r#"COPY disclosure.other_table (id) FROM stdin;"#;
        assert!(!should_copy_table_data(Some(stmt), Some(&pattern)));
    }

    #[test]
    fn can_generate_shorter_dump_from_14mb_fixture() {
        let fixture = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("fixtures")
            .join("limit_100")
            .join("src.dump");
        let output = NamedTempFile::new().expect("temp output should be created");

        run(Cli {
            dump_loc: fixture
                .to_str()
                .expect("fixture path should be valid UTF-8")
                .to_string(),
            output_dump: output.path().to_path_buf(),
            row_limit: Some(50),
            row_sample: None,
            table_pattern: None,
        })
        .expect("mock dump generation should succeed");

        let input_size = fs::metadata(&fixture)
            .expect("fixture metadata should be readable")
            .len();
        let output_size = fs::metadata(output.path())
            .expect("output metadata should be readable")
            .len();
        assert!(
            output_size < input_size,
            "expected output dump to be smaller than fixture (output={output_size}, input={input_size})"
        );

        let output_dump = output
            .path()
            .to_str()
            .expect("output path should be valid UTF-8")
            .to_string();
        let reader =
            pg_dumpster::reader::open_reader(output_dump).expect("output dump should be readable");
        assert!(
            !reader.toc.entries.is_empty(),
            "output dump should contain entries"
        );
    }
}
