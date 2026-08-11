#!/bin/sh
# Bootstrap script for the CS3704 assignment repository.
# It installs the Git hooks defined in the local "hooks" directory.
# After installing hooks, it can be extended to perform a one‑off
# learning‑opportunity payload (e.g., a welcome message or initial check).

# Run the hook installer
./hooks/setup-git-hooks.sh

# Placeholder for additional bootstrap actions
# echo "Setup complete. Happy coding!"
