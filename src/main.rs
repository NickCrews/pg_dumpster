use anyhow::{Context, Result};
use clap::{Parser, Subcommand};
use libpgdump::Entry;
use libpgdump::OffsetState;
use libpgdump::TableOfContents;
use pg_dumpster::entries::filter_entries_to_table_datas;
use pg_dumpster::reader::open_reader;
use pg_dumpster::table_read::{Engine, Format, ReadTableOptions, read_table};
use pg_dumpster::tsv::{TsvStream, parse_copy_statement};
use std::fs::{self};
use std::io::{self};
use std::path::PathBuf;

#[derive(Parser)]
#[command(author, version, about = "Unpack a Postgres custom dump file")]
struct Cli {
    #[command(subcommand)]
    command: Command,
}

#[derive(Subcommand)]
enum Command {
    /// Unpack all tables and the TOC into a directory
    All {
        /// Path to the Postgres custom dump file
        dump_path: String,
        /// Output directory
        output_dir: PathBuf,
    },
    /// Print the table of contents as JSON to stdout
    Toc {
        /// Path to the Postgres custom dump file
        dump_path: String,
    },
    /// Operate on tables, e.g. list or stream a specific table as TSV
    #[command(subcommand)]
    Table(TableCommand),
}

#[derive(Subcommand)]
enum TableCommand {
    /// list all tables in the dump
    Ls {
        /// Path to the Postgres custom dump file
        dump_path: String,
    },
    /// Read the data of a table.
    Read {
        /// Path to the Postgres custom dump file
        dump_path: String,
        /// Qualified table name, e.g. "my_schema.my_table"
        table_name: String,
        /// Where to write the output (defaults to stdout if not provided)
        #[arg(long)]
        output: Option<PathBuf>,
        /// The format of the output.
        #[arg(long, default_value = "tsv-raw")]
        format: Format,
        /// Conversion engine (for CSV/Parquet/JSON formats).
        #[arg(long, default_value = "arrow")]
        engine: Engine,
    },
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    match cli.command {
        Command::All {
            dump_path,
            output_dir,
        } => cmd_all(&dump_path, &output_dir),
        Command::Toc { dump_path } => cmd_toc(&dump_path),
        Command::Table(TableCommand::Ls { dump_path }) => cmd_table_ls(&dump_path),
        Command::Table(TableCommand::Read {
            dump_path,
            table_name,
            output,
            format,
            engine,
        }) => {
            let opts = ReadTableOptions {
                table_name,
                output,
                format,
                engine,
            };
            read_table(&dump_path, opts)
        }
    }
}

fn cmd_all(dump_path: &str, output_dir: &PathBuf) -> Result<()> {
    if !output_dir.exists() {
        fs::create_dir_all(output_dir).context("Failed to create output directory")?;
    }

    let mut loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;

    let data_entries: Vec<Entry> = loader
        .toc
        .entries
        .iter()
        .filter(|e| e.data_state == OffsetState::Set && e.had_dumper)
        .cloned()
        .collect();
    let toc_json = toc_to_json(&loader.toc);

    for entry in &data_entries {
        let file_name = format!("data_{}.tsv", entry.dump_id);
        let file_path = output_dir.join(&file_name);

        eprintln!(
            "Extracting entry {} ({:?}) to {}",
            entry.dump_id, entry.desc, file_name
        );

        let mut tsv_stream = TsvStream::new(&mut loader, entry).with_context(|| {
            format!("failed to create TSV stream for dump_id {}", entry.dump_id)
        })?;

        let mut out_file = fs::File::create(&file_path)
            .with_context(|| format!("failed to create output file {:?}", file_path))?;
        io::copy(&mut tsv_stream, &mut out_file)
            .with_context(|| format!("failed to copy data for dump_id {}", entry.dump_id))?;
    }

    let toc_path = output_dir.join("toc.json");
    fs::write(&toc_path, toc_json).context("Failed to write toc.json")?;

    eprintln!("Unpacked dump to {:?}", output_dir);
    Ok(())
}

fn cmd_toc(dump_path: &str) -> Result<()> {
    let loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;
    print!("{}", toc_to_json(&loader.toc));
    Ok(())
}

fn cmd_table_ls(dump_path: &str) -> Result<()> {
    let loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;

    let table_entries = filter_entries_to_table_datas(&loader.toc.entries);
    for entry in table_entries {
        if let Some(copy_stmt) = &entry.copy_stmt {
            if let Ok(Some((table_name, _))) = parse_copy_statement(copy_stmt) {
                println!("{}", table_name);
            }
        }
    }

    Ok(())
}

fn toc_to_json(toc: &TableOfContents) -> String {
    let mut json_entries = Vec::new();
    for entry in &toc.entries {
        json_entries.push(entry_to_json(entry));
    }
    format!(
        "{{\n  \"compression\": \"{:?}\",\n  \"entries\": [\n{}\n  ]\n}}",
        toc.compression,
        json_entries.join(",\n")
    )
}

fn entry_to_json(entry: &Entry) -> String {
    format!(
        "{{\n  \"dump_id\": {},\n  \"tag\": {},\n  \"desc\": \"{:?}\",\n  \"defn\": {},\n  \"copy_stmt\": {},\n  \"data_state\": \"{:?}\",\n  \"offset\": {},\n  \"had_dumper\": {}\n}}",
        entry.dump_id,
        entry
            .tag
            .as_ref()
            .map(|s| format!("\"{}\"", json_escape(s)))
            .unwrap_or_else(|| "null".to_string()),
        entry.desc,
        entry
            .defn
            .as_ref()
            .map(|s| format!("\"{}\"", json_escape(s)))
            .unwrap_or_else(|| "null".to_string()),
        entry
            .copy_stmt
            .as_ref()
            .map(|s| format!("\"{}\"", json_escape(s)))
            .unwrap_or_else(|| "null".to_string()),
        entry.data_state,
        entry.offset,
        entry.had_dumper,
    )
}

fn json_escape(s: &str) -> String {
    s.replace('\\', "\\\\")
        .replace('"', "\\\"")
        .replace('\n', "\\n")
        .replace('\r', "\\r")
        .replace('\t', "\\t")
}
