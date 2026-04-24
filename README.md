## pg_dumpster

Rust util CLI to inspect and read a PostgreSQL custom dump (`pg_dump -Fc`).

### Performance

As of April 17, 2026, can extract all the table data from the 80Gb https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_a.dump
into a directory of parquets in ~10 minutes on a 2021 M1 Macbook Pro.