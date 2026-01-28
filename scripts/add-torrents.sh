#!/usr/bin/env bash
rpc_auth="$1"
files_dir="$2"

existing_hashes=$(transmission-remote --auth "$rpc_auth" -t all -i \
  | awk -F': ' '/Hash:/ {print $2}')

find "$files_dir" -type f -name "*.torrent" -print0 | while IFS= read -r -d '' torrent_file; do
  echo "Processing: $torrent_file"

  torrent_hash=$(transmission-show "$torrent_file" \
    | awk -F': ' '/Hash v1/ {print $2}')

  if echo "$existing_hashes" | grep -qx "$torrent_hash"; then
    echo "  -> already present"
  else
    transmission-remote --auth "$rpc_auth" \
      -w "$(dirname "$torrent_file")" \
      -a "$torrent_file"
    echo "  -> added"
  fi
done
