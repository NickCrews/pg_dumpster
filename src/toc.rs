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
        "version_string": toc.version.to_string(),
        "version": {
            "major": toc.version.major,
            "minor": toc.version.minor,
            "rev": toc.version.rev,
        },
        "int_size": toc.int_size,
        "off_size": toc.off_size,
        "format": format!("{:?}", toc.format),
        "compression": format!("{:?}", toc.compression),
        "timestamp": {
            "sec": toc.timestamp.second,
            "min": toc.timestamp.minute,
            "hour": toc.timestamp.hour,
            "mday": toc.timestamp.day,
            "mon": toc.timestamp.month,
            "year": toc.timestamp.year,
            "isdst": toc.timestamp.is_dst,
        },
        "timestamp_iso": timestamp_to_iso(&toc.timestamp),
        "dbname": toc.dbname,
        "server_version": toc.server_version,
        "dump_version": toc.dump_version,
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

fn timestamp_to_iso(ts: &libpgdump::Timestamp) -> String {
    format!(
        "{:04}-{:02}-{:02}T{:02}:{:02}:{:02}{}",
        ts.year + 1900,
        ts.month,
        ts.day,
        ts.hour,
        ts.minute,
        ts.second,
        if ts.is_dst > 0 { " DST" } else { "" }
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use libpgdump::Timestamp;

    #[test]
    fn test_timestamp_to_iso() {
        let ts = Timestamp {
            second: 15,
            minute: 30,
            hour: 14,
            day: 25,
            month: 12,
            year: 123,
            is_dst: 0,
        };
        assert_eq!(timestamp_to_iso(&ts), "2023-12-25T14:30:15");

        let ts_dst = Timestamp {
            second: 0,
            minute: 0,
            hour: 10,
            day: 1,
            month: 7,
            year: 123,
            is_dst: 1,
        };
        assert_eq!(timestamp_to_iso(&ts_dst), "2023-07-01T10:00:00 DST");
    }
}
