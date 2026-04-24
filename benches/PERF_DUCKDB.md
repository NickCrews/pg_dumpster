# Performance Notes

These are some performance notes from the original implementation that used duckdb.
They are no longer relevant, but I'm keeping them around so we can see how we ended up
with the current parquet/arrow implementation.

To run the benchmark: `cargo bench`.
This uses criterion and executes the code many times to get consistent timings.
It takes 30-120 seconds to run.
Importantly, this uses a release build, not a debug build. The debug build is like 10X slower.

To profile, printing out timings manually: `cargo test --release --features profiling restore_ofec_committee_history -- --nocapture`.
This runs the restore function once, using our profiling harness macros that we add
around sections to measure time taken on each invocation, number of times called, total time taken.
Then prints out the results in a table.
This is useful to actually see what parts of code were slow, if you need quick and dirty numbers.

A more nuanced view you can get with `just bench`, which runs a full sampling profiler
and then can show the trace as a flamegraph in a very nice web UI.

## What Is Measured

We take the 14Mb dump file (262,276 rows, 76 columns) at `fixtures/ofec_committee_history_14mb.dump`.
and load it into an empty duckdb database.
We make a mock local http server that supports range requests,
which emulates the S3 server that the real dump files are hosted on.
Therefore the client is able to take advantage of parrallel reads if it wants.
Note that a big difference between the bench and prod is that we have no network latency.

## Current Behavior

- stream_rows_to_duckdb: ~3.72s total
  - In-transaction COPY: ~1.72s (3 × 100k-row chunks, avg 573ms each)
  - COMMIT: ~1.34s
  - Parse/transform: ~0.90s (overlapped with COPY via pipeline)
  - Read lines: ~0.56s (overlapped with COPY via pipeline)
- initialize_duckdb: ~0.07s
- build_data_tasks: ~0.4ms

Interpretation:

- Restore is still the dominant cost, but drastically faster.
- Inside restore, COPY + COMMIT dominate (~3.1s), with parsing fully overlapped via pipeline.

## Changes Already Applied

1. Chunk sizing
- Increased `chunk_rows` default from `10_000` to `100_000`.
- Updated the e2e test invocation to also use `100_000`.
- This produced the biggest measured win (fewer `COPY` calls, fewer temp files/chunk boundaries).

2. TSV->CSV transform path
- Reworked per-row conversion to stream directly into CSV output instead of building intermediate `Vec<Option<String>>` per row.
- Reused decode buffer for escaped fields.
- Added fast path for fields without backslashes to avoid escape decode work.
- Changed normalization to use borrowed values when possible (`Cow`) to reduce cloning.

3. HTTP range reader
- Increased default range fetch size from 4 MiB to 16 MiB.
- Aligned cache windows to fetch-size boundaries.
- Removed per-request debug `eprintln!` logs.

4. Local range server test harness behavior
- Reduced nonblocking `WouldBlock` sleep from 10ms to 1ms.

5. DuckDB connection tuning
- `SET preserve_insertion_order = false`: Allows DuckDB to use parallel execution for CSV reads.
- We COULD do `SET force_compression = 'uncompressed'`, but otherwise our disk space is going to be enormous.

6. Pipelined parsing + transaction-wrapped COPY
- Main thread parses TSV→CSV and sends chunks via crossbeam channel.
- Background loader thread receives chunks and executes COPY inside a single transaction.
- In-transaction COPYs are ~3x faster (~590ms vs ~1.5s) since they skip per-statement commit.
- Parsing is fully overlapped with COPY execution.

7. WAL checkpoint deferral
- Loader thread sets `wal_autocheckpoint = '1TB'` to prevent mid-load checkpointing.

8. Using uint64 instead of the decimal(19,0) used in upstream postgres.
The decimal(19,0) is physically backed by a int128, so it was really slow.
Parsing the strings into it were taking like half of the loading time
in each `INSERT` call.

## What We Know Is *Not* the Main Bottleneck

- Final validation/export work in the e2e test is negligible (~0.4s).
- HTTP logging overhead was real noise, but not the dominant contributor to the original ~50s.
- Pure parsing optimizations alone did not explain the majority of the initial runtime.

## Current Bottlenecks

1. DuckDB COMMIT (WAL flush)
- ~1.3-1.4s for 262k rows of uncompressed data.
- This is largely I/O bound and hard to reduce further without sacrificing durability.

2. In-transaction COPY (CSV parse + insertion)
- ~1.7-1.8s total for 3 chunks of 100k rows.
- DuckDB internally parallelizes CSV reading with `preserve_insertion_order=false`.
- CSV re-parsing overhead is unavoidable with the temp-file COPY approach.

3. Per-field parsing/normalization (overlapped)
- ~0.9s for the fixture, but fully overlapped with COPY via the pipeline.
- Not on the critical path unless parsing becomes slower than COPY.

## Approaches Tried and Rejected

1. DuckDB Appender API
- Bypasses CSV roundtrip, but per-value FFI overhead (76 columns × 262k rows = ~20M calls) makes it ~2x slower than COPY.

2. `INSERT FROM read_csv()` with hardcoded columns
- Roughly equivalent performance to COPY with explicit format args.

3. `/dev/shm` temp files
- No measurable improvement; temp file I/O is already fast (~80ms).

4. Larger chunk sizes (500k)
- Marginal improvement over 100k with pipeline. 100k is the sweet spot for overlap.

## Suggested Next Tuning (Priority Order)

1. Reduce per-field string churn further
- Avoid normalize/escape work when input clearly requires none.
- Consider specialized hot paths for common simple rows.
- Expected impact: low (parsing is no longer on the critical path).

2. Reassess HTTP fetch behavior with realistic remote latency
- Current fixture server is local; network tuning may matter more in production than in this test.
- Expected impact for this e2e: low-medium.

## Measurement Notes

- The terminal harness can interrupt long quiet commands. Heartbeat polling and detached runs were needed for reliable completion capture.
- Keep measurements comparable by using the same test and fixture each run.

## Recommended Repeatable Perf Loop

1. Run the benchmark script as described above to see overall time change.
2. Run the profiling script as described above to see where time is spent.
3. Make one isolated change.
4. Run the benchmark and profiling scripts again so see the difference.
5. Keep correctness anchored on the existing e2e expected outputs.

## Open Questions

- Can WAL checkpoint be fully deferred until after restore for additional gains?
- For very large dumps, does the pipeline approach scale linearly or does memory pressure become a concern?
- Switch to `flamegraph` for sampling based profiling instead of explicitly adding profiling sections?