#!/bin/sh
set -eu

# Render injects PORT at runtime. UUID and WS_PATH are set as env vars in the
# Render dashboard (never committed). Defaults below are for LOCAL TEST ONLY.
PORT="${PORT:-8080}"
UUID="${UUID:-e48b7122-5581-4ad5-8ad4-1bcacaf261e3}"
WS_PATH="${WS_PATH:-/cdn}"

sed -e "s/__PORT__/${PORT}/" \
    -e "s/__UUID__/${UUID}/" \
    -e "s|__WS_PATH__|${WS_PATH}|" \
    /app/config.template.json > /app/config.json

exec sing-box run -c /app/config.json
