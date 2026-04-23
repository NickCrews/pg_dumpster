use anyhow::{Context, Result};
use libpgdump::CustomDataLoader;
use libpgdump::format::custom::TableDataReader;
use regex::Regex;

use crate::reader::DumpReader;

pub fn parse_copy_statement(statement: &str) -> Result<Option<(String, Vec<String>)>> {
    let re = Regex::new(r"(?i)^COPY\s+(.+?)\s*\((.+)\)\s+FROM\s+stdin;?\s*$")?;
    let Some(captures) = re.captures(statement.trim()) else {
        return Ok(None);
    };
    let table_raw = captures.get(1).map(|m| m.as_str()).unwrap_or_default();
    let table_name = normalize_qualified_name(table_raw);
    let column_names = captures
        .get(2)
        .map(|m| m.as_str())
        .unwrap_or_default()
        .split(',')
        .map(|s| s.trim().trim_matches('"').to_owned())
        .collect();
    Ok(Some((table_name, column_names)))
}

fn normalize_qualified_name(value: &str) -> String {
    let parts = value
        .split('.')
        .map(|part| quote_identifier(part.trim()))
        .collect::<Vec<_>>();
    parts.join(".")
}

fn quote_identifier(value: &str) -> String {
    let trimmed = value.trim();
    if trimmed.starts_with('"') && trimmed.ends_with('"') && trimmed.len() >= 2 {
        return trimmed.to_owned();
    }
    format!("\"{}\"", trimmed.replace('"', "\"\""))
}

/// Wraps the raw stream of data in the dump file into a new stream that is a valid TSV file.
/// The raw stream does not have a header row, and ends with a line containing just "\." instead of EOF.
/// This wrapper adds a header row based on the column names parsed from the COPY statement,
/// and removes the final "\." line so that the stream can be read as a normal TSV file until EOF.
pub struct TsvStream<R> {
    inner: std::io::BufReader<R>,
    header: std::io::Cursor<Vec<u8>>,
    done_header: bool,
    buffer: Vec<u8>,
    buffer_pos: usize,
    done: bool,
}

pub fn to_tsv_stream<R: std::io::Read>(raw_stream: R, column_names: &[String]) -> TsvStream<R> {
    let header_str = column_names.join("\t") + "\n";
    TsvStream {
        inner: std::io::BufReader::new(raw_stream),
        header: std::io::Cursor::new(header_str.into_bytes()),
        done_header: false,
        buffer: Vec::new(),
        buffer_pos: 0,
        done: false,
    }
}

impl<'a> TsvStream<TableDataReader<'a, DumpReader>> {
    pub fn new(
        reader: &'a mut CustomDataLoader<DumpReader>,
        entry: &libpgdump::Entry,
    ) -> Result<Self> {
        let stream = reader
            .open_data_reader(entry.dump_id)
            .with_context(|| {
                format!(
                    "failed to open streaming reader for dump_id {}",
                    entry.dump_id
                )
            })?
            .ok_or_else(|| anyhow::anyhow!("no data found for dump_id {}", entry.dump_id))?;

        let column_names = if let Some(copy_stmt) = &entry.copy_stmt {
            parse_copy_statement(copy_stmt)?
                .map(|(_, cols)| cols)
                .unwrap_or_default()
        } else {
            Vec::new()
        };
        Ok(to_tsv_stream(stream, &column_names))
    }
}

impl<R: std::io::Read> std::io::Read for TsvStream<R> {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        use std::io::BufRead;

        if self.done && self.buffer_pos >= self.buffer.len() {
            return Ok(0);
        }

        if !self.done_header {
            let n = self.header.read(buf)?;
            if n > 0 {
                return Ok(n);
            }
            self.done_header = true;
        }

        if self.buffer_pos < self.buffer.len() {
            let available = self.buffer.len() - self.buffer_pos;
            let to_copy = std::cmp::min(available, buf.len());
            buf[..to_copy]
                .copy_from_slice(&self.buffer[self.buffer_pos..self.buffer_pos + to_copy]);
            self.buffer_pos += to_copy;
            return Ok(to_copy);
        }

        self.buffer.clear();
        self.buffer_pos = 0;

        let n = self.inner.read_until(b'\n', &mut self.buffer)?;
        if n == 0 {
            self.done = true;
            return Ok(0);
        }

        if self.buffer.starts_with(b"\\.") {
            let is_end_marker = match self.buffer.as_slice() {
                b"\\." | b"\\.\n" | b"\\.\r\n" => true,
                _ => false,
            };
            if is_end_marker {
                self.done = true;
                self.buffer.clear();
                return Ok(0);
            }
        }

        let available = self.buffer.len();
        let to_copy = std::cmp::min(available, buf.len());
        buf[..to_copy].copy_from_slice(&self.buffer[0..to_copy]);
        self.buffer_pos = to_copy;

        Ok(to_copy)
    }
}
