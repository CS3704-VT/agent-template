---
# Seed for @assignment analyze. `analyze <name>` copies this to <name>.md at the
# repo root (e.g. PM1.1.md, HW1.md) and fills the fields. Review and override as needed.
name:            # e.g. PM1.1, HW1  (set by analyze)
type:
id:
due:
source:          # fetched URL or pasted body the assignment came from
source_hash:
builds_on: []    # list of prior assignment files this builds on (e.g. [PM1.1]); empty for one-offs
submission:
  method:
  target:
  include: [<name>.md]   # replace <name> with this assignment's name
  # file: path/to/deliverable    ← fill in for file/files methods
  # link: <auto from git remote> ← override only if submitting a different repo
  instructions: |
    # (optional custom instructions for external method)
---

# Requirements
<!-- @assignment analyze fetches/parses the assignment source into a checklist here. -->

## Verification status
<!-- @assignment analyze walks the repo and records [x]/[ ] + evidence per deliverable. -->
