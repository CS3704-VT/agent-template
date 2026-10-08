# arc-claude.ps1 — start Claude Code against Virginia Tech's ARC LLM API (Windows PowerShell).
#
# Usage:
#   .\.claude\scripts\arc-claude.ps1
#   .\.claude\scripts\arc-claude.ps1 --agent system-architect
#   $env:ARC_MODEL = "GLM-5.3"; .\.claude\scripts\arc-claude.ps1
#
# Requires ARC_API_KEY and the VT network/VPN. Mirrors arc-claude.sh.
$ErrorActionPreference = "Stop"
$Root = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path

if (-not $env:ARC_API_KEY) {
  Write-Error "arc-claude: ARC_API_KEY is not set. Get a key at https://llm.arc.vt.edu (Settings -> Account -> API keys); see docs/STUDENT_GUIDE.md."
  exit 1
}
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Error "arc-claude: Claude Code is not installed (npm install -g @anthropic-ai/claude-code)."
  exit 1
}

$env:ANTHROPIC_BASE_URL = "https://llm-api.arc.vt.edu/api/"
$env:ANTHROPIC_API_KEY = $env:ARC_API_KEY
if (-not $env:CLAUDE_CODE_MAX_OUTPUT_TOKENS) { $env:CLAUDE_CODE_MAX_OUTPUT_TOKENS = "8192" }
if (-not $env:API_TIMEOUT_MS) { $env:API_TIMEOUT_MS = "600000" }
$Model = if ($env:ARC_MODEL) { $env:ARC_MODEL } else { "DeepSeek-V4.1-Flash" }
$m = [Array]::IndexOf($args, "--model")
if ($m -ge 0 -and $m + 1 -lt $args.Count) { $Model = $args[$m + 1] }
if (-not $env:ANTHROPIC_DEFAULT_HAIKU_MODEL) { $env:ANTHROPIC_DEFAULT_HAIKU_MODEL = $Model }

$i = [Array]::IndexOf($args, "--agent")
if ($i -ge 0 -and $i + 1 -lt $args.Count) {
  $agent = $args[$i + 1]
  if (-not (Test-Path (Join-Path $Root ".claude\agents\$agent.md"))) {
    Write-Error "arc-claude: no agent named '$agent' (see .claude/agents/)."; exit 1
  }
  $phase = Get-Content (Join-Path $Root "PHASE.md") -Raw
  $live = [regex]::Match($phase, "(?s)## Available agents this phase(.*?)\n## ").Groups[1].Value
  if ($live -notmatch "\b$([regex]::Escape($agent))\b") {
    Write-Error "arc-claude: '$agent' is not available this phase (see PHASE.md)."; exit 1
  }
}

Set-Location $Root
if ($args -contains "--model") { & claude @args } else { & claude --model $Model @args }
exit $LASTEXITCODE
