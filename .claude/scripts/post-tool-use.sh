#!/usr/bin/env bash
set -uo pipefail

# learning-opportunities-auto: PostToolUse hook (matches Bash tool)
#
# Fires after every Bash tool use. Checks whether the command was a
# `git commit` and, if so, suggests that the agent offer a learning exercise.
# The skill itself decides whether the commit's content is worth an
# exercise — this hook just provides the nudge at the right moment.
#
# Registered for Claude Code in .claude/settings.json (PostToolUse, matcher
# "Bash"). Claude Code sends JSON on stdin:
#   {"session_id": "...", "tool_name": "Bash",
#    "tool_input": {"command": "..."}, "tool_response": {...}, ...}
# Codex sends the same protocol but may name the field "cmd".
#
# Uses jq when available; falls back to grep/sed otherwise.
#
# NOTE: opencode does not implement this protocol. The in-opencode equivalent
# is the plugin .claude/plugins/learning-opportunity.ts (tool.execute.after),
# which shares this script's /tmp state-file scheme.

INPUT=$(cat)

# ---------------------------------------------------------------------------
# Extract the shell command the tool ran. Only tool_input is inspected — the
# tool_response holds command output, and matching against it would fire on
# e.g. `git status` printing "nothing to commit".
# ---------------------------------------------------------------------------

if command -v jq >/dev/null 2>&1; then
  COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // .tool_input.cmd // .command // .cmd // empty' 2>/dev/null)
  SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty' 2>/dev/null)
else
  # Fallback: whitespace-tolerant field extraction. Escaped quotes inside the
  # command truncate the match, which is fine — `git commit` comes first.
  COMMAND=$(echo "$INPUT" | grep -oE '"(command|cmd)"[[:space:]]*:[[:space:]]*"[^"]*' | head -1 | sed -E 's/^"(command|cmd)"[[:space:]]*:[[:space:]]*"//')
  SESSION_ID=$(echo "$INPUT" | grep -oE '"session_id"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/^"session_id"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# `git` must start a command word and `commit` must be its subcommand (global
# options like `-C <dir>` allowed in between), so paths such as
# .git/hooks/post-commit don't match.
if ! echo "$COMMAND" | grep -Eq '(^|[;&|(`[:space:]])git([[:space:]]+(-C[[:space:]]+[^[:space:]]+|-[^[:space:]]+))*[[:space:]]+commit([[:space:];&|)]|$)'; then
  exit 0
fi

if [[ -z "$SESSION_ID" ]]; then
  exit 0
fi

# ---------------------------------------------------------------------------
# Session state: track how many exercises have been offered this session.
# Uses a temp file keyed on session ID; resets when the session ends.
# ---------------------------------------------------------------------------

STATE_FILE="${TMPDIR:-/tmp}/lo_auto_${SESSION_ID//[^a-zA-Z0-9_-]/_}.state"

offers=0
if [[ -f "$STATE_FILE" ]]; then
  offers=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
fi

# Stop after 5 offers per session.
if [[ "$offers" -ge 5 ]]; then
  exit 0
fi

# Record the offer.
echo $(( offers + 1 )) > "$STATE_FILE"

# ---------------------------------------------------------------------------
# Emit suggestion for Opencode via structured JSON. PostToolUse hooks must
# output JSON with hookSpecificOutput on exit 0 to inject context.
# The message contains no special characters that need escaping.
# ---------------------------------------------------------------------------

cat <<'HOOK_JSON'
{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"[learning-opportunities-auto] The user just committed code. Per the learning-opportunities skill, consider whether this is a good moment to offer a learning exercise. If the committed work involved new files, schema changes, architectural decisions, refactors, or unfamiliar patterns, ask the user (one short sentence) if they'd like a 10-15 minute exercise. Do not start the exercise until they confirm. If they decline, note it — no more offers this session."}}
HOOK_JSON

exit 0
