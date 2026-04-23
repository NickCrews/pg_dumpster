# https://github.com/mstange/samply
# I installed with `cargo install --locked samply`
# First, build a profiling build and then run the binary with the given fixture name

format := "parquet"
engine := "arrow"
table := "disclosure.fec_fitem_sched_a_1975_1976"

profile CASE:
    #!/bin/bash
    SRC_DUMP=$(just dump_of_case {{CASE}})
    OUT_PATH=fixtures/{{CASE}}/profile_gen/out.{{format}}
    PROFILE_PATH=fixtures/{{CASE}}/profile.gen.json.gz
    cargo build --profile profiling --features profiling
    # dsymutil collects DWARF from object files into a .dSYM bundle that samply needs for symbolication
    dsymutil ./target/profiling/pg_dumpster
    samply record --output $PROFILE_PATH ./target/profiling/pg_dumpster table read $SRC_DUMP {{table}} --engine {{engine}} --format {{format}} --output $OUT_PATH

profile_load CASE:
    #!/bin/bash
    PROFILE_PATH=fixtures/{{CASE}}/profile.gen.json.gz
    samply load $PROFILE_PATH

# given a case name, give the path to the source dump, either committed or generated, preferring the committed if it exists.
dump_of_case CASE:
    #!/bin/bash
    SRC_COMMITTED_DUMP=fixtures/{{CASE}}/src.dump
    SRC_GENERATED_DUMP=fixtures/{{CASE}}/src.gen.dump
    if [ -f "$SRC_COMMITTED_DUMP" ]; then
        echo "$SRC_COMMITTED_DUMP"
    else
        echo "$SRC_GENERATED_DUMP"
    fi