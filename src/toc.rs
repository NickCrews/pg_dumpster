use anyhow::{Context, Result};
use libpgdump::{Entry, TableOfContents};
use std::io::Write;

use crate::reader::open_reader;

pub fn cmd_toc<W: Write>(dump_path: &str, out: &mut W) -> Result<()> {
    let loader = open_reader(dump_path).context("Failed to open dump and read TOC")?;
    write!(out, "{}", toc_to_json(&loader.toc))?;
    Ok(())
}

pub fn toc_to_json(toc: &TableOfContents) -> String {
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
