use anyhow::{Context, Result};
use clap::{Parser, Subcommand};
use libpgdump::Entry;
use libpgdump::OffsetState;
use pg_dumpster::entries;
use pg_dumpster::reader::open_reader;
use pg_dumpster::table_read::{Format, ReadTableOptions, read_entry, read_table};
use pg_dumpster::toc::{cmd_toc, toc_to_json};
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
        /// The format of the output. If omitted, inferred from the output
        /// file extension (.parquet, .csv, .tsv), falling back to tsv-raw
        /// when writing to stdout.
        #[arg(long)]
        format: Option<Format>,
    },
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    match cli.command {
        Command::All {
            dump_path,
            output_dir,
        } => cmd_all(&dump_path, &output_dir),
        Command::Toc { dump_path } => cmd_toc(&dump_path, &mut io::stdout()),
        Command::Table(TableCommand::Ls { dump_path }) => cmd_table_ls(&dump_path),
        Command::Table(TableCommand::Read {
            dump_path,
            table_name,
            output,
            format,
        }) => {
            let opts = ReadTableOptions {
                table_name,
                output,
                format,
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
        read_entry(&mut loader, entry, Some(file_path), Format::TsvRaw)?;
    }

    let toc_path = output_dir.join("toc.json");
    fs::write(&toc_path, toc_json).context("Failed to write toc.json")?;

    eprintln!("Unpacked dump to {:?}", output_dir);
    Ok(())
}

fn cmd_table_ls(dump_path: &str) -> Result<()> {
    let loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;

    let table_entries = entries::filter_entries_to_table_datas(&loader.toc.entries);
    for entry in table_entries {
        println!(
            "{}",
            entries::qualified_name(entry).unwrap_or_else(|| format!("dump_id={}", entry.dump_id))
        );
    }

    Ok(())
}
