# pg_dumpster

Rust util CLI to inspect and read a PostgreSQL custom dump (`pg_dump -Fc`).

---

## Usage

- Get the table of contents from a local file: `pg_dumpster toc mydump.dump > toc.json`
- You can also pass a url. We use HTTP range requests for efficient seeking within the remote file: `pg_dumpster toc https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_a.dump > toc.json`
- List all the table data entries: `pg_dumpster table ls mydump.dump`
- Read a single table of data: `pg_dumpster table read mydump.dump myschema.mytable --output out.parquet`
- Supports passing `--format=csv|parquet|tsv-raw`. The `tsv-raw` format is exactly what
  the decompressed data looks like in the dump, in the format that psql would expect.
  Eg NULLs are represented as the two character sequence "\N".
  This isn't very compatible with most csv readers, so the `--format=csv` option unescapes
  these into a format that most csv readers (eg duckdb) would understand correctly.
  Using the `--format=parquet` is pretty obvious.

## Features

- Uses streaming for very low memory usage.
- Streaming also allows for low disk usage, you can stream straight from a remote URL
  to a local parquet file with no intermediate disk usage.
- Allows outputting to stdout for piping.

## Limitations

This exports all data as strings, it does not preserve the datatypes of the original table.
This is because it's nontrivial to infer the schema of the table from the dump file.
For instance a postgres table could be defined using the [INHERITS](https://www.postgresql.org/docs/current/tutorial-inheritance.html) syntax.
In order to determine the schema in the general sense, we would need to actually
spin up a real postgres DB, restore the schema, and then perform some introspection
queries to determine the table's schema. I didn't implement this.
You can always implement this yourself in a followup step.

## Install

I haven't done the effort of releasing prebuilt binaries. You will need to compile yourself:

`cargo install --git https://github.com/NickCrews/pg_dumpster --rev main`

Use a pinned revision if you want stability.

## Motivation

I wrote this to power https://github.com/NickCrews/fec-dump-parquets.
This runs every week to turn the postgres .dump files that the
US Federal Elections Commission publishes into parquet files
for much easier analysis.

## Performance

As of April 17, 2026, can extract all the table data from the 80Gb https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_a.dump
into a directory of parquets in ~10 minutes on a 2021 M1 Macbook Pro.