#!/usr/bin/env bash
# SessionStart hook: tell the agent its Claude Code session ID so every
# log entry (teacher-log.jsonl, learning-log.jsonl) uses the same `session`
# value — see "Session identity" in CLAUDE.md.
set -uo pipefail
SESSION_ID=$(cat | grep -o '"session_id" *: *"[^"]*"' | head -1 | sed 's/.*: *"//;s/"$//')
[ -n "$SESSION_ID" ] || exit 0
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"CS3704 session ID: %s"}}\n' "$SESSION_ID"
