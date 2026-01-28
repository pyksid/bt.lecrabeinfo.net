#!/usr/bin/env bash
d="$(realpath "$1")"
tracker="$2"

find "$d" -type f ! -name "*.torrent" -print0 | while IFS= read -r -d '' f; do
  t="$f.torrent"
  [ -f "$t" ] || transmission-create -o "$t" -t "$tracker" --private "$f"
done
