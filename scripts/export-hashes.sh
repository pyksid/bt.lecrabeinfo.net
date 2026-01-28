#!/usr/bin/env bash
rpc_auth="$1"
output_file="$2"

transmission-remote --auth "$rpc_auth" -t all -i |
awk -F': ' '
  /^  Name:/ {name=$2}
  /^  Hash( v1)?:/ {hash=$2}
  hash && name {print hash " # " name; hash=""; name=""}
' > "$output_file"
