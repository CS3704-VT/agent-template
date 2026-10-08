# Current phase: baseline (2 of 3)

> **Course-owned file.** This file is updated by the course team as each phase branch is released. Students: read it to see which agents are available this phase; do not edit it.

## Available agents this phase

dcbrown · assignment · requirements-analyst · product-manager · ux-ui-designer · system-architect

Start one with `baker run <short name>` (`dcbrown`, `assignment`, `requirements`, `product`, `ux`, `architect`) or `.claude/scripts/arc-claude.sh --agent <name>`. Planning and building happen in the default session (`baker run claude`); press Shift+Tab there for Plan Mode.

## Available skills this phase

analysis . heuristics-nielsen . implementation-sketch . raci-matrix . specification

## Phase roadmap

| # | Branch | Adds |
|---|--------|------|
| 1 | `main` (baseline) | default session + Plan Mode, dcbrown, assignment |
| 2 | `phase/02-requirements-design` | requirements-analyst, product-manager, ux-ui-designer, system-architect |
| 3 | `phase/03-testing-maintenance` | `tester`, `maintainer`, and `review` agents |

Phases are cumulative: merging a later phase branch also brings all earlier phase-gated agents.

