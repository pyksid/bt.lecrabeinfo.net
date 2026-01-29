#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(realpath "$1")"
TRACKER_UDP="$2"
TRACKER_HTTP="$3"

comment="Source: Le Crabe Info (https://lecrabeinfo.net)"

find "$SOURCE_DIR" -type f ! -name '*.torrent' -print0 |
while IFS= read -r -d '' file; do
  torrent_file="$file.torrent"

  if [ -f "$torrent_file" ]; then
    continue
  fi

  transmission-create \
    --outfile "$torrent_file" \
    --tracker "$TRACKER_UDP" \
    --tracker "$TRACKER_HTTP" \
    --comment "$comment" \
    --private \
    "$file"
done
