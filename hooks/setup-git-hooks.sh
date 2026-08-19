#!/bin/sh
# Installer for repository Git hooks.
# Copies the hook scripts from the local "hooks" directory into the .git/hooks directory.
# If the repository is not a Git repo, the script exits silently.

# Determine top‑level of the repo (or exit if not a repo)
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$REPO_ROOT" ]; then
  echo "Not a Git repository – skipping hook installation."
  exit 0
fi

# Ensure the .git/hooks directory exists
HOOK_DIR="$REPO_ROOT/.git/hooks"
mkdir -p "$HOOK_DIR"

# Install each hook present in the local hooks directory
HOOKS_DIR=$(cd "$(dirname "$0")" && pwd)
for hook in $(ls "$HOOKS_DIR" 2>/dev/null); do
  # Skip the installer script itself
  if [ "$hook" = "setup-git-hooks.sh" ]; then
    continue
  fi
  src="$HOOKS_DIR/$hook"
  dest="$HOOK_DIR/$hook"
  if [ -f "$src" ]; then
    cp "$src" "$dest"
    chmod +x "$dest"
    echo "Installed $hook hook."
  fi
done
