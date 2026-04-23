use crate::arrow_tsv::{DEFAULT_BATCH_SIZE, TsvBatchReader};
use crate::entries::find_table_entry;
use crate::reader::{DumpReader, open_reader};
use crate::tsv::{TsvStream, parse_copy_statement};
use anyhow::{Context, Result};
use clap::ValueEnum;
use parquet::arrow::ArrowWriter;
use parquet::basic::Compression;
use parquet::file::properties::WriterProperties;
use std::fs::{self, create_dir_all};
use std::io::{self, BufRead, BufReader};
use std::path::{Path, PathBuf};

#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
pub struct ReadTableOptions {
    /// Qualified table name, e.g. "my_schema.my_table"
    pub table_name: String,
    /// Where to write the output (defaults to stdout if not provided)
    pub output: Option<PathBuf>,
    /// The format of the output.
    pub format: Format,
}

#[derive(Copy, Clone, PartialEq, Eq, PartialOrd, Ord, ValueEnum)]
pub enum Format {
    /// Apache Parquet columnar format.
    Parquet,
    /// A TSV format that closely matches the raw data in the dump file, with minimal processing.
    /// It contains a header row with column names and with the trailing `\.` line from the raw file removed,
    /// but otherwise does not modify the data.
    /// This means that NULLs are represented as the two character sequence `\N`,
    /// newlines are represented as the two character sequence `\n`, and so on.
    /// For more info, see https://www.postgresql.org/docs/current/sql-copy.html
    TsvRaw,
    /// Standard CSV with proper quoting, NULLs as empty strings, and escaped special characters.
    Csv,
}

impl Default for Format {
    fn default() -> Self {
        Format::Parquet
    }
}

pub fn read_table(dump_path: &str, opts: ReadTableOptions) -> Result<()> {
    let ReadTableOptions {
        table_name,
        output,
        format,
        ..
    } = opts;
    let mut loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;
    let entry = find_table_entry(&loader.toc.entries, &table_name)?.clone();
    let mut tsv_stream = TsvStream::new(&mut loader, &entry)
        .with_context(|| format!("failed to create TSV stream for {table_name}"))?;

    match format {
        Format::TsvRaw => {
            let mut out: Box<dyn io::Write> =
                if let Some(output_path) = output {
                    Box::new(fs::File::create(&output_path).with_context(|| {
                        format!("failed to create output file {:?}", output_path)
                    })?)
                } else {
                    Box::new(io::stdout())
                };
            let mut progress: ProgressReader<
                &mut TsvStream<libpgdump::format::custom::TableDataReader<'_, DumpReader>>,
            > = ProgressReader::new(&mut tsv_stream, table_name.to_string());
            eprintln!("[{table_name}] starting stream (format: tsv-raw)");
            let rows = io::copy(&mut progress, &mut out)
                .with_context(|| format!("failed to stream data for {table_name}"))?;
            eprintln!("[{table_name}] done ({} bytes written)", rows);
            return Ok(());
        }
        Format::Csv => {
            let output_path =
                output.ok_or_else(|| anyhow::anyhow!("--output is required for csv format"))?;
            create_dir_all(output_path.parent().unwrap_or_else(|| Path::new("."))).with_context(
                || {
                    format!(
                        "failed to create parent directories for output file {:?}",
                        output_path
                    )
                },
            )?;
            let column_names = entry
                .copy_stmt
                .as_deref()
                .and_then(|s| parse_copy_statement(s).ok().flatten())
                .map(|(_, cols)| cols)
                .ok_or_else(|| anyhow::anyhow!("no column names parsed from COPY statement"))?;
            eprintln!(
                "[{table_name}] starting arrow csv write ({} cols, output: {:?})",
                column_names.len(),
                output_path
            );

            let mut buf_reader = BufReader::with_capacity(1 << 17, tsv_stream);
            let mut header_line = Vec::new();
            buf_reader
                .read_until(b'\n', &mut header_line)
                .with_context(|| "failed to read header line")?;

            let file = fs::File::create(&output_path)
                .with_context(|| format!("failed to create output file {:?}", output_path))?;
            let buf_file = io::BufWriter::with_capacity(1 << 20, file);

            let mut batch_reader =
                TsvBatchReader::new(buf_reader, &column_names, DEFAULT_BATCH_SIZE);

            let (tx, rx) = crossbeam_channel::bounded::<arrow::record_batch::RecordBatch>(4);
            let table_name_owned = table_name.to_string();
            let writer_handle = std::thread::spawn(move || -> Result<u64> {
                let mut writer = arrow::csv::WriterBuilder::new()
                    .with_header(true)
                    .build(buf_file);
                let mut total_rows = 0u64;
                let mut last_logged = 0u64;
                for batch in rx.iter() {
                    total_rows += batch.num_rows() as u64;
                    writer.write(&batch).context("failed to write csv batch")?;
                    if total_rows - last_logged >= 1_000_000 {
                        eprintln!("[{table_name_owned}] {} rows written", total_rows);
                        last_logged = total_rows;
                    }
                }
                Ok(total_rows)
            });

            while let Some(batch) = batch_reader.next_batch()? {
                if tx.send(batch).is_err() {
                    break;
                }
            }
            drop(tx);

            let total_rows = writer_handle
                .join()
                .map_err(|_| anyhow::anyhow!("writer thread panicked"))??;

            eprintln!("[{table_name}] done ({} rows)", total_rows);
            return Ok(());
        }
        Format::Parquet => {
            let output_path =
                output.ok_or_else(|| anyhow::anyhow!("--output is required for parquet format"))?;
            create_dir_all(output_path.parent().unwrap_or_else(|| Path::new("."))).with_context(
                || {
                    format!(
                        "failed to create parent directories for output file {:?}",
                        output_path
                    )
                },
            )?;
            let column_names = entry
                .copy_stmt
                .as_deref()
                .and_then(|s| parse_copy_statement(s).ok().flatten())
                .map(|(_, cols)| cols)
                .ok_or_else(|| anyhow::anyhow!("no column names parsed from COPY statement"))?;
            eprintln!(
                "[{table_name}] starting arrow parquet write ({} cols, output: {:?})",
                column_names.len(),
                output_path
            );

            let mut buf_reader = BufReader::with_capacity(1 << 17, tsv_stream);
            let mut header_line = Vec::new();
            buf_reader
                .read_until(b'\n', &mut header_line)
                .with_context(|| "failed to read header line")?;

            let file = fs::File::create(&output_path)
                .with_context(|| format!("failed to create output file {:?}", output_path))?;
            let buf_file = io::BufWriter::with_capacity(1 << 20, file);

            let mut batch_reader =
                TsvBatchReader::new(buf_reader, &column_names, DEFAULT_BATCH_SIZE);
            let schema = batch_reader.schema();
            let props = WriterProperties::builder()
                .set_compression(Compression::SNAPPY)
                .build();
            let writer = ArrowWriter::try_new(buf_file, schema, Some(props))
                .context("failed to create parquet writer")?;

            let (tx, rx) = crossbeam_channel::bounded::<arrow::record_batch::RecordBatch>(4);
            let table_name_owned = table_name.to_string();
            let writer_handle = std::thread::spawn(move || -> Result<u64> {
                let mut writer = writer;
                let mut total_rows = 0u64;
                let mut last_logged = 0u64;
                for batch in rx.iter() {
                    total_rows += batch.num_rows() as u64;
                    writer
                        .write(&batch)
                        .context("failed to write parquet batch")?;
                    if total_rows - last_logged >= 1_000_000 {
                        eprintln!("[{table_name_owned}] {} rows written", total_rows);
                        last_logged = total_rows;
                    }
                }
                writer.close().context("failed to close parquet writer")?;
                Ok(total_rows)
            });

            while let Some(batch) = batch_reader.next_batch()? {
                if tx.send(batch).is_err() {
                    break;
                }
            }
            drop(tx);

            let total_rows = writer_handle
                .join()
                .map_err(|_| anyhow::anyhow!("writer thread panicked"))??;

            eprintln!("[{table_name}] done ({} rows)", total_rows);
            return Ok(());
        }
    }
}

struct ProgressReader<R> {
    inner: R,
    row_count: u64,
    last_logged_milestone: u64,
    table_name: String,
}

impl<R: io::Read> ProgressReader<R> {
    const LOG_INTERVAL: u64 = 10_000_000;

    fn new(inner: R, table_name: String) -> Self {
        Self {
            inner,
            row_count: 0,
            last_logged_milestone: 0,
            table_name,
        }
    }
}

impl<R: io::Read> io::Read for ProgressReader<R> {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        let n = self.inner.read(buf)?;
        if n > 0 {
            self.row_count += buf[..n].iter().filter(|&&b| b == b'\n').count() as u64;
            let milestone = (self.row_count / Self::LOG_INTERVAL) * Self::LOG_INTERVAL;
            if milestone > self.last_logged_milestone {
                self.last_logged_milestone = milestone;
                eprintln!("[{}] {} rows streamed", self.table_name, milestone);
            }
        }
        Ok(n)
    }
}
