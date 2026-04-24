use anyhow::{Result, bail};
use libpgdump::Entry;
use libpgdump::OffsetState;
use regex::Regex;

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

/// Combines as either `"namespace"."tag"` or just `"tag"` if no namespace.
pub fn qualified_name(entry: &Entry) -> Option<String> {
    entry.tag.as_ref().map(|tag| {
        if let Some(namespace) = &entry.namespace {
            format!(
                "\"{}\".\"{}\"",
                namespace.replace('"', "\"\""),
                tag.replace('"', "\"\"")
            )
        } else {
            format!("\"{}\"", tag.replace('"', "\"\""))
        }
    })
}

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

#[cfg(test)]
mod tests {
    use super::*;
    use libpgdump::{Entry, ObjectType, OffsetState, Section};

    fn mock_entry() -> Entry {
        Entry {
            dump_id: 0,
            had_dumper: false,
            table_oid: "".to_string(),
            oid: "".to_string(),
            tag: None,
            desc: ObjectType::Table,
            section: Section::None,
            defn: None,
            drop_stmt: None,
            copy_stmt: None,
            namespace: None,
            tablespace: None,
            tableam: None,
            relkind: None,
            owner: None,
            with_oids: false,
            dependencies: vec![],
            data_state: OffsetState::NotSet,
            offset: 0,
            filename: None,
        }
    }

    #[test]
    fn test_qualified_name() {
        let mut entry = mock_entry();
        assert_eq!(qualified_name(&entry), None);

        // Tag, no namespace
        entry.tag = Some("my_table".to_string());
        entry.namespace = None;
        assert_eq!(qualified_name(&entry).as_deref(), Some("\"my_table\""));

        // Tag and namespace
        entry.tag = Some("my_table".to_string());
        entry.namespace = Some("public".to_string());
        assert_eq!(
            qualified_name(&entry).as_deref(),
            Some("\"public\".\"my_table\"")
        );

        // Quotes inside tag and namespace
        entry.tag = Some("my_\"table\"".to_string());
        entry.namespace = Some("pub\"lic\"".to_string());
        assert_eq!(
            qualified_name(&entry).as_deref(),
            Some("\"pub\"\"lic\"\"\".\"my_\"\"table\"\"\"")
        );
    }
}
