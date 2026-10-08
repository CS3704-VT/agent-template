#!/usr/bin/env bash
# log-jsonl.sh — append one JSON object to a CS3704 learning log.
#
# Usage: .claude/scripts/log-jsonl.sh <teacher-log.jsonl|learning-log.jsonl|concept-explain-log.jsonl> '<json object>'
#
# The only write the read-only course agents are allowed to make. Refuses any
# other target file and any argument that isn't a single-line JSON object.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [ $# -ne 2 ]; then
  echo "usage: log-jsonl.sh <log-file> '<json object>'" >&2
  exit 2
fi
case "$1" in
  teacher-log.jsonl | learning-log.jsonl | concept-explain-log.jsonl) ;;
  *) echo "log-jsonl: refusing to write '$1' (allowed: teacher-log.jsonl, learning-log.jsonl, concept-explain-log.jsonl)" >&2; exit 2 ;;
esac
case "$2" in
  *$'\n'*) echo "log-jsonl: entry must be a single line" >&2; exit 2 ;;
  \{*\}) ;;
  *) echo "log-jsonl: entry must be a JSON object" >&2; exit 2 ;;
esac
if command -v python3 >/dev/null 2>&1; then
  printf '%s' "$2" | python3 -c 'import json,sys; o=json.load(sys.stdin); assert isinstance(o,dict)' 2>/dev/null \
    || { echo "log-jsonl: entry is not valid JSON" >&2; exit 2; }
fi
printf '%s\n' "$2" >> "$ROOT/$1"
