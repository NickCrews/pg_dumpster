#!/usr/bin/env bash
# Generate a PostgreSQL custom-format dump (-Fc) from a plain SQL fixture file.
#
# Usage: scripts/gen_dump.sh <src.sql> <out.dump>
#
# Spins up an ephemeral `postgres` Docker container, loads the SQL via psql,
# runs `pg_dump -Fc` inside the container, and writes the result to <out.dump>.
# The only host dependency is `docker`.
#
# Environment overrides:
#   PG_IMAGE  postgres image to use (default: postgres:17)
#   PG_DB     database name to create and dump (default: fixture)

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "usage: $0 <src.sql> <out.dump>" >&2
    exit 2
fi

SRC_SQL="$1"
OUT_DUMP="$2"

if [[ ! -f "$SRC_SQL" ]]; then
    echo "[gen_dump] source SQL file not found: $SRC_SQL" >&2
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "[gen_dump] docker is required but not on PATH" >&2
    exit 1
fi

IMAGE="${PG_IMAGE:-postgres:17}"
DB_NAME="${PG_DB:-fixture}"
CONTAINER="pg_dumpster_gen_$$_$(date +%s)"

cleanup() {
    docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "[gen_dump] starting container $CONTAINER ($IMAGE)" >&2
cmd="docker run -d --rm \
    --name '$CONTAINER' \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -e POSTGRES_DB='$DB_NAME' \
    '$IMAGE'"
echo "[gen_dump] running: $cmd" >&2
CONTAINER=$(eval "$cmd")

echo "[gen_dump] waiting for postgres to become ready" >&2
ready=0
for _ in $(seq 1 60); do
    if docker exec "$CONTAINER" pg_isready -U postgres -d "$DB_NAME" >/dev/null 2>&1; then
        ready=1
        break
    fi
    sleep 1
done
if [[ $ready -ne 1 ]]; then
    echo "[gen_dump] postgres did not become ready in 60s" >&2
    docker logs "$CONTAINER" >&2 || true
    exit 1
fi

echo "[gen_dump] loading $SRC_SQL" >&2
docker exec -i "$CONTAINER" \
    psql -v ON_ERROR_STOP=1 -U postgres -d "$DB_NAME" < "$SRC_SQL" >&2

mkdir -p "$(dirname "$OUT_DUMP")"
TMP_OUT="${OUT_DUMP}.tmp.$$"
echo "[gen_dump] writing custom dump to $OUT_DUMP" >&2
# pg_dump -Fc must write to a real (seekable) file so it can backfill data
# block offsets into the TOC. When piped to stdout, offsets stay NotSet and
# readers that rely on them (like libpgdump) skip the data entries.
docker exec "$CONTAINER" pg_dump -Fc -U postgres -d "$DB_NAME" -f /tmp/out.dump
docker cp "$CONTAINER:/tmp/out.dump" "$TMP_OUT"
mv "$TMP_OUT" "$OUT_DUMP"

echo "[gen_dump] done" >&2
