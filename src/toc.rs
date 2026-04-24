use anyhow::{Context, Result};
use libpgdump::{Entry, TableOfContents};
use serde_json;
use std::io::Write;

use crate::reader::open_reader;

pub fn cmd_toc<W: Write>(dump_path: &str, out: &mut W) -> Result<()> {
    let loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;
    writeln!(out, "{}", toc_to_json(&loader.toc))?;
    Ok(())
}

pub fn toc_to_json(toc: &TableOfContents) -> String {
    let entries: Vec<_> = toc.entries.iter().map(entry_to_json).collect();

    let doc = serde_json::json!({
        "compression": format!("{:?}", toc.compression),
        "entries": entries,
    });

    serde_json::to_string_pretty(&doc).unwrap()
}

pub fn entry_to_json(entry: &Entry) -> serde_json::Value {
    serde_json::json!({
        "dump_id": entry.dump_id,
        "had_dumper": entry.had_dumper,
        "table_oid": entry.table_oid,
        "oid": entry.oid,
        "tag": entry.tag,
        "desc": format!("{:?}", entry.desc),
        "section": format!("{:?}", entry.section),
        "defn": entry.defn,
        "drop_stmt": entry.drop_stmt,
        "copy_stmt": entry.copy_stmt,
        "namespace": entry.namespace,
        "tablespace": entry.tablespace,
        "tableam": entry.tableam,
        "relkind": entry.relkind,
        "owner": entry.owner,
        "with_oids": entry.with_oids,
        "dependencies": entry.dependencies,
        "data_state": format!("{:?}", entry.data_state),
        "offset": entry.offset,
        "filename": entry.filename,
    })
}
