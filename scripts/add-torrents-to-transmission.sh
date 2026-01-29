#!/usr/bin/env bash
set -euo pipefail

RPC_AUTH="$1"
TORRENTS_DIR="$2"

existing_hashes="$(
  transmission-remote --auth "$RPC_AUTH" -t all -i |
  awk -F': ' '/Hash:/ {print $2}'
)"

find "$TORRENTS_DIR" -type f -name '*.torrent' -print0 |
while IFS= read -r -d '' torrent_file; do
  torrent_hash="$(
    transmission-show "$torrent_file" |
    awk -F': ' '/Hash v1/ {print $2}'
  )"

  if echo "$existing_hashes" | grep -qx "$torrent_hash"; then
    continue
  fi

  transmission-remote \
    --auth "$RPC_AUTH" \
    --add "$torrent_file" \
    --download-dir "$(dirname "$torrent_file")"
done
