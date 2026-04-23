use anyhow::{Context, Result};
use arrow::array::{ArrayRef, StringBuilder};
use arrow::datatypes::{DataType, Field, Schema};
use arrow::record_batch::RecordBatch;
use std::io::BufRead;
use std::sync::Arc;

pub const DEFAULT_BATCH_SIZE: usize = 65_536;

pub struct TsvBatchReader<R: BufRead> {
    reader: R,
    schema: Arc<Schema>,
    builders: Vec<StringBuilder>,
    batch_size: usize,
    done: bool,
    line_buf: Vec<u8>,
    field_buf: Vec<u8>,
}

impl<R: BufRead> TsvBatchReader<R> {
    pub fn new(reader: R, column_names: &[String], batch_size: usize) -> Self {
        let fields: Vec<Field> = column_names
            .iter()
            .map(|n| Field::new(n, DataType::Utf8, true))
            .collect();
        let schema = Arc::new(Schema::new(fields));
        let builders = column_names
            .iter()
            .map(|_| StringBuilder::with_capacity(batch_size, batch_size * 32))
            .collect();
        Self {
            reader,
            schema,
            builders,
            batch_size,
            done: false,
            line_buf: Vec::with_capacity(4096),
            field_buf: Vec::with_capacity(128),
        }
    }

    pub fn schema(&self) -> Arc<Schema> {
        self.schema.clone()
    }

    pub fn next_batch(&mut self) -> Result<Option<RecordBatch>> {
        if self.done {
            return Ok(None);
        }
        let n_cols = self.builders.len();
        let mut rows = 0usize;
        while rows < self.batch_size {
            self.line_buf.clear();
            let n = self.reader.read_until(b'\n', &mut self.line_buf)?;
            if n == 0 {
                self.done = true;
                break;
            }
            let line = strip_newline(&self.line_buf);
            if line == b"\\." {
                self.done = true;
                break;
            }
            parse_line(line, &mut self.builders, n_cols, &mut self.field_buf)?;
            rows += 1;
        }
        if rows == 0 {
            return Ok(None);
        }
        let arrays: Vec<ArrayRef> = self
            .builders
            .iter_mut()
            .map(|b| Arc::new(b.finish()) as ArrayRef)
            .collect();
        Ok(Some(RecordBatch::try_new(self.schema.clone(), arrays)?))
    }
}

fn strip_newline(s: &[u8]) -> &[u8] {
    let mut end = s.len();
    if end > 0 && s[end - 1] == b'\n' {
        end -= 1;
        if end > 0 && s[end - 1] == b'\r' {
            end -= 1;
        }
    }
    &s[..end]
}

fn parse_line(
    line: &[u8],
    builders: &mut [StringBuilder],
    n_cols: usize,
    field_buf: &mut Vec<u8>,
) -> Result<()> {
    let mut col = 0usize;
    field_buf.clear();
    let mut is_null = false;
    let mut field_started = false;
    let mut i = 0;
    while i < line.len() {
        let b = line[i];
        if b == b'\t' {
            if col >= n_cols {
                anyhow::bail!("too many columns (expected {})", n_cols);
            }
            finalize_field(&mut builders[col], field_buf, is_null)?;
            col += 1;
            field_buf.clear();
            is_null = false;
            field_started = false;
            i += 1;
            continue;
        }
        if b == b'\\' && i + 1 < line.len() {
            let next = line[i + 1];
            if !field_started && next == b'N' {
                is_null = true;
                field_started = true;
                i += 2;
                continue;
            }
            let ch = match next {
                b'b' => 0x08,
                b'f' => 0x0c,
                b'n' => b'\n',
                b'r' => b'\r',
                b't' => b'\t',
                b'v' => 0x0b,
                b'\\' => b'\\',
                other => other,
            };
            field_buf.push(ch);
            field_started = true;
            i += 2;
            continue;
        }
        field_buf.push(b);
        field_started = true;
        i += 1;
    }
    if col >= n_cols {
        anyhow::bail!("too many columns (expected {})", n_cols);
    }
    finalize_field(&mut builders[col], field_buf, is_null)?;
    col += 1;
    if col != n_cols {
        anyhow::bail!("wrong column count: got {}, expected {}", col, n_cols);
    }
    Ok(())
}

fn finalize_field(builder: &mut StringBuilder, buf: &[u8], is_null: bool) -> Result<()> {
    if is_null {
        builder.append_null();
    } else {
        let s = std::str::from_utf8(buf).context("field is not valid UTF-8")?;
        builder.append_value(s);
    }
    Ok(())
}
