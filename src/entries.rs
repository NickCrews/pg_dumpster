use crate::tsv::parse_copy_statement;
use anyhow::{Result, bail};
use libpgdump::Entry;
use libpgdump::OffsetState;

pub fn find_table_entry<'a>(entries: &'a [Entry], table_name: &str) -> Result<&'a Entry> {
    let normalized_target = normalize_table_name(table_name);

    let matches: Vec<&Entry> = entries
        .iter()
        .filter(|e| is_table_data_entry(e))
        .filter(|e| {
            e.copy_stmt
                .as_deref()
                .and_then(|s| parse_copy_statement(s).ok().flatten())
                .map(|(name, _)| name == normalized_target)
                .unwrap_or(false)
        })
        .collect();

    match matches.len() {
        0 => bail!(
            "no table found matching {:?}. Available tables: {:?}",
            table_name,
            filter_entries_to_table_datas(entries)
                .iter()
                .filter_map(|e| e
                    .copy_stmt
                    .as_deref()
                    .and_then(|s| parse_copy_statement(s).ok().flatten())
                    .map(|(name, _)| name))
                .collect::<Vec<_>>()
        ),
        1 => Ok(matches[0]),
        _ => bail!(
            "multiple entries match {:?}: dump_ids {:?}",
            table_name,
            matches.iter().map(|e| e.dump_id).collect::<Vec<_>>()
        ),
    }
}

fn is_table_data_entry(entry: &Entry) -> bool {
    return entry.data_state == OffsetState::Set && entry.had_dumper && entry.copy_stmt.is_some();
}

pub fn filter_entries_to_table_datas<'a>(entries: &'a [Entry]) -> Vec<&'a Entry> {
    entries.iter().filter(|e| is_table_data_entry(e)).collect()
}

fn normalize_table_name(name: &str) -> String {
    name.split('.')
        .map(|part| {
            let trimmed = part.trim();
            if trimmed.starts_with('"') && trimmed.ends_with('"') && trimmed.len() >= 2 {
                trimmed.to_owned()
            } else {
                format!("\"{}\"", trimmed.replace('"', "\"\""))
            }
        })
        .collect::<Vec<_>>()
        .join(".")
}
