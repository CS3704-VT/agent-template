#!/usr/bin/env bash
set -uo pipefail

# SessionStart hook: injects the Codex session ID into the agent's context so
# log entries (teacher-log.jsonl, learning-log.jsonl) can carry it in their
# `session` field — see "Session identity" in AGENTS.md. Codex adds plain
# stdout from SessionStart hooks as developer context.
#
# Registered in .codex/hooks.json. Uses jq when available; falls back to
# grep/sed otherwise.

INPUT=$(cat)

if command -v jq >/dev/null 2>&1; then
  SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty' 2>/dev/null)
else
  SESSION_ID=$(echo "$INPUT" | grep -oE '"session_id"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/^"session_id"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

[[ -n "$SESSION_ID" ]] && echo "CS3704 session id: $SESSION_ID"

exit 0
