#!/usr/bin/env bash
set -euo pipefail

RPC_AUTH="$1"
OUTPUT_FILE="$2"

transmission-remote --auth "$RPC_AUTH" -t all -i |
awk -F': ' '
  /^  Name:/ {name=$2}
  /^  Hash( v1)?:/ {hash=$2}
  hash && name {
    print hash " # " name
    hash=""
    name=""
  }
' > "$OUTPUT_FILE"
