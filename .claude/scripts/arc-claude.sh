#!/usr/bin/env bash
# arc-claude.sh — start Claude Code against Virginia Tech's ARC LLM API.
#
# Usage:
#   .claude/scripts/arc-claude.sh                         # default session
#   .claude/scripts/arc-claude.sh --agent system-architect
#   ARC_MODEL=GLM-5.3 .claude/scripts/arc-claude.sh       # pick a model
#   .claude/scripts/arc-claude.sh --model gpt-oss-120b --resume
#
# Requires ARC_API_KEY (your ARC Open WebUI API key) and the VT network/VPN.
# Bare `claude` does NOT use ARC — always start through this script
# (or `baker run claude` / `baker run <agent>`).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [ -z "${ARC_API_KEY:-}" ]; then
  echo "arc-claude: ARC_API_KEY is not set. Get a key at https://llm.arc.vt.edu" >&2
  echo "            (Settings -> Account -> API keys); see docs/STUDENT_GUIDE.md." >&2
  exit 1
fi
if ! command -v claude >/dev/null 2>&1; then
  echo "arc-claude: Claude Code is not installed (npm install -g @anthropic-ai/claude-code)." >&2
  exit 1
fi

export ANTHROPIC_BASE_URL="https://llm-api.arc.vt.edu/api/"
export ANTHROPIC_API_KEY="$ARC_API_KEY"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS="${CLAUDE_CODE_MAX_OUTPUT_TOKENS:-8192}"
export API_TIMEOUT_MS="${API_TIMEOUT_MS:-600000}"

MODEL="${ARC_MODEL:-DeepSeek-V4.1-Flash}"
model_given=""
args=("$@")
for ((i = 0; i < ${#args[@]}; i++)); do
  case "${args[$i]}" in
    --agent) agent="${args[$((i + 1))]:-}" ;;
    --agent=*) agent="${args[$i]#--agent=}" ;;
    --model) MODEL="${args[$((i + 1))]:-$MODEL}"; model_given=1 ;;
    --model=*) MODEL="${args[$i]#--model=}"; model_given=1 ;;
  esac
done
# Claude Code runs some background work on a "Haiku" model; ARC doesn't serve
# Claude models, so point it at the session model.
export ANTHROPIC_DEFAULT_HAIKU_MODEL="${ANTHROPIC_DEFAULT_HAIKU_MODEL:-$MODEL}"

# Refuse agents that aren't live this phase (PHASE.md "Available agents" line).
if [ -n "${agent:-}" ]; then
  if [ ! -f "$ROOT/.claude/agents/$agent.md" ]; then
    echo "arc-claude: no agent named '$agent' (see .claude/agents/)." >&2
    exit 1
  fi
  live="$(sed -n '/^## Available agents this phase/,/^## /p' "$ROOT/PHASE.md")"
  if ! printf '%s\n' "$live" | grep -qw -- "$agent"; then
    echo "arc-claude: '$agent' is not available this phase (see PHASE.md)." >&2
    exit 1
  fi
fi

cd "$ROOT"
if [ -n "$model_given" ]; then
  exec claude "$@"
fi
exec claude --model "$MODEL" "$@"
