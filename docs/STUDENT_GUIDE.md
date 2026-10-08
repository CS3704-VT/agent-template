# CS3704 — Student Guide to the Agent Template

This repository is your **agentic development environment** for CS3704 (Intermediate Software Design and Engineering). It configures [Claude Code](https://code.claude.com/) — running on Virginia Tech's ARC models — with course-specific agents, skills, and helper scripts you will use all semester.

## What's inside

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Shared instructions every agent follows (policy, logging, budgets, hand-offs). Worth reading once. |
| `PHASE.md` | Which agents are live this phase, and the roadmap of what arrives next. **Check this first.** |
| `.claude/agents/*.md` | The course agents, each started as its own conversation. The baseline agents are **`dcbrown`** (for course administration) and **`assignment`** (for assignment requirements and packaging); planning and coding happen in the **default session** (Plan Mode for planning). The available agents will grow with each phase — see `PHASE.md`. |
| `.claude/skills/*` | On-demand capabilities: `quiz`, `concept-explain`, `analysis`, `specification`, `heuristics-nielsen`, `implementation-sketch`, `learning-goal`, `learning-opportunities`, `orient`, `submit`. |
| `.claude/settings.json` | Claude Code project settings: permissions plus the `SessionStart` hook (session ID for logs) and `PostToolUse` hook (learning-exercise nudge after `git commit`s made **inside** Claude Code). |
| `.claude/scripts/` | Helper scripts: `arc-claude.sh` / `arc-claude.ps1` (start Claude Code on ARC), `fetch-lecture.sh` (lecture PDF text extraction), `submit-*.sh` (submission packaging), `log-jsonl.sh` (learning logs), and the `session-start.sh` / `post-tool-use.sh` hooks. |
| `hooks/`, `setup.sh` | Git-hook infrastructure. `setup.sh` installs the hooks into `.git/hooks/`. `post-commit` offers learning opportunities for commits made **outside** Claude Code; `pre-commit` is a stub. |
| `docs/templates/` | Starter templates for course artifacts: `assignment.md`, `use-case.md`, `user-story.md`, `use-case-diagram.md`, `sequence-diagram.md`, `class-diagram.md`, `data-model.md`, `adr.md`. |

## Template architecture (where things live)

The template is organized so that course-owned configuration can live alongside your own project/assignment files. Here's the layout:

```
agent-template/
├── README.md            # landing page + quick start (replace with your project README later)
├── CLAUDE.md            # shared policy every agent follows — read once
├── PHASE.md             # course-owned; which agents are live this phase
├── HW1.md / PM1.1.md     # per-assignment details, one file per assignment, created by the assignment agent's analyze
├── .gitignore           # ignores logs, goals, zips, .env, runtime deps, .tmp/
├── docs/                # this guide + starter templates
│   ├── README.md
│   ├── STUDENT_GUIDE.md
│   └── templates/
│       ├── assignment.md       # seed for assignment `analyze` (copied to <name>.md at repo root)
│       ├── use-case.md         # text use cases (requirements-analyst)
│       ├── user-story.md       # user stories + Given/When/Then criteria (requirements-analyst)
│       ├── use-case-diagram.md # UML use case diagrams, ASCII (requirements-analyst)
│       ├── sequence-diagram.md # UML sequence diagrams, ASCII (requirements-analyst)
│       ├── class-diagram.md    # UML class diagrams, ASCII (system-architect)
│       ├── data-model.md       # ER data models, ASCII (system-architect)
│       └── adr.md              # Architectural Decision Records (system-architect)
├── hooks/               # git-hook sources
│   ├── pre-commit       # stub (learning logic moved to post-commit)
│   ├── post-commit      # commits made OUTSIDE Claude Code: offers to launch it for a learning exercise
│   └── setup-git-hooks.sh  # copies hooks into .git/hooks/
└── .claude/             # Claude Code config home
    ├── settings.json    # permissions + hooks (session ID, commit nudge)
    ├── agents/*.md      # one file per agent (dcbrown, assignment, …)
    ├── skills/<name>/SKILL.md   # on-demand capabilities (quiz, concept-explain, …)
    ├── scripts/         # arc-claude.sh (ARC launcher), hooks, fetch-lecture.sh, submit-*.sh, log-jsonl.sh
    └── topics/          # allowed-concepts.txt, concept-lecture-map.json
```

### Template Editing

- **Course-owned (extend, don't edit):** Please do not edit `CLAUDE.md`, `PHASE.md`, `.claude/agents/*`, `.claude/skills/*`, `.claude/scripts/*`, `.claude/settings.json`, `docs/STUDENT_GUIDE.md`, or other files critical for configuring and using this template. Please also do not modify the auto-generated files, such as logs, goal files, and submission zips — see [Auto-generated files](#auto-generated-files).
- **Yours to edit:** You may edit your project code and documentation and the per-assignment analysis files (e.g. `HW1.md`, `PM1.1.md`) to include/modify assignment requirements.
- **If you find an issue with this template, please contact Dr. Brown or submit a pull request!** 

## Getting started

1. **Set your API key.** The launcher `.claude/scripts/arc-claude.sh` connects Claude Code to the **ARC** LLM API and reads the key from the `ARC_API_KEY` environment variable. You should be able to set it in your shell using the following commands:
   ```sh
   export ARC_API_KEY=sk-... # MacOS and Linux
   setx ARC_API_KEY=sk-...   # Windows
   ```
  - To obtain an API Key for the Virignia Tech Advanced Research Computing, go to [https://llm.arc.vt.edu](https://llm.arc.vt.edu) then select go to your user profile and select _Settings_ -> _Account_ -> _API keys_. More details on obtaining your API key are available [here](https://www.docs.arc.vt.edu/ai/011_llm_api_arc_vt_edu.html#llm-api-arc-vt-edu). **Do _not_ share your API key!**
  - To use this agentic framework with ARC, you must be within the Virginia Tech network (either using the wi-fi on campus or VPN).
  - Additional details on setting an environment variable for your system are available [here](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-set-an-environment-variable.html). Please follow the instructions for setting a persistent/permanent variable to avoid resetting your ARC_API_KEY variable every time.


2. **Check you have the appropriate dependencies**:
   ```sh
   baker check CS3704-VT/profile:agent-template.yml
   ```
   - The pre-bake checks should pass. The post-bake checks will not pass until after running `baker bake`.
   
3. **Clone the repository, configure your environment, and run the bootstrap script:**
   ```sh
   git clone https://github.com/CS3704-VT/agent-template
   cd agent-template
   baker bake .
   baker run setup
   ```
   - The first time you run it, the script sets a git hook that surfaces the `learning-opportunities` skill automatically as you work (see [Learning features](#learning-features) below) and creates a **semester‑goal** file under `~/.config/cs3704-goals/semester-goal.md` to outline your learning goals for CS3704 this semester. 
   - On subsequent runs (once the semester goal exists), the script automatically launches the **individual learning‑goal** (`learning-goal.md`) to outline your learning goals for specific assignments. After you complete that, you will be asked whether this is a **team** assignment; answering “y” will also launch the **team learning‑goal** (`team-goal.md`), which should be completed collaboratively with your teammates for group assignments.
   - The script uses the `learning‑goal` skill to set up your goals. You can change or update your goals by typing `/learning-goal` (see [Learning features](#learning-features) below).
4. **Start Claude Code on ARC:**
   ```sh
   cd agent-template
   baker run claude                 # or: .claude/scripts/arc-claude.sh
   ```
   - **Always start through `baker run …` or `arc-claude.sh`.** Bare `claude` does not use ARC — it asks you to log in to an Anthropic account instead.
   - On the first launch, Claude Code asks whether you trust this folder and whether to use the API key found in your environment. Answer **Yes** to both (the key is your ARC key). Until the folder is trusted, the template's permissions and hooks are ignored.
   - Windows without Git Bash/WSL: run `.\.claude\scripts\arc-claude.ps1` in PowerShell.
   - The default model is `DeepSeek-V4.1-Flash`. See [Models](#models) for details on available models and how to switch.

## Phases & agents

Agents are released in phases over the semester rather than all at once. **`PHASE.md` is the source of truth** for which agents are available right now — read it before reaching for an agent, because the set changes each phase.

- **Baseline (now):** the default session (with Plan Mode), `dcbrown`, and `assignment`.
- **Later phases** add the requirements, process, architect, designer, tester, maintainer, and review agents as the course progresses.

## Using the agents

Every agent is its own conversation that can ask you questions directly. Start one with `baker run <short name>`; return to an earlier conversation with `.claude/scripts/arc-claude.sh --agent <name> --resume`.

| Start with | Agent | What it does |
|---|---|---|
| `baker run claude` | default session | Implements features, writes/runs tests, refactors, and saves files. It is the primary editor. Press **Shift+Tab** for **Plan Mode** to analyze tasks and produce plans without editing. |
| `baker run dcbrown` | `dcbrown` | Answers course questions, runs quizzes and concept explanations. |
| `baker run assignment` | `assignment` | Retrieves assignment details, verifies completion, and packages submission. |
| `baker run requirements` | `requirements-analyst` | Requirements, use cases, user stories, acceptance criteria (phase 2). |
| `baker run product` | `product-manager` | Product value, prioritization, process (phase 2). |
| `baker run architect` | `system-architect` | Architecture, class diagrams, ADRs, design patterns (phase 2). |
| `baker run ux` | `ux-ui-designer` | UI design and usability evaluation (phase 2). |

Phase-gated agents arrive with their phase branch; the launcher refuses an agent that `PHASE.md` doesn't list as live. Agents stay in their role: if you ask one for another role's work, it tells you which agent to start. The requirements, product, architect, and UX agents are read-only — they return finished artifacts, which you save from the default session.

## Workflow: a typical session

### End-to-end walkthrough

1. **One-time setup** — Set `ARC_API_KEY`, run `baker check`, `baker bake`, and `baker run setup` (see [Getting started](#getting-started)).
2. **Set a learning goal** — type `/learning-goal` (writes `learning-goal.md`); see [Learning features](#learning-features).
3. **Extract the assignment requirements** — start `baker run assignment` and type `analyze PM1.2` (or pass a link: `analyze https://…`) to automatically gather the details and requirements of a particular assignment. This writes a per-assignment `<name>.md` file at the repo root (e.g. `PM1.2.md` or `HW3.md`). _This will need to be manually reviewed by you!_ A bare `PMx` resolves to the project README (overview, not an assignment); an unknown name or missing file produces a graceful "no assignment found" error.
4. **Pick the right agent** — the default session for code/tests/edits (Shift+Tab into Plan Mode for brainstorming), `baker run dcbrown` for course questions and quizzes, and `baker run assignment` for assignment details and submission. Check [PHASE.md](../PHASE.md) for phase-gated agents; see [Using the agents](#using-the-agents).
5. **Plan → build** — ideate in Plan Mode; when the plan is solid, approve it and the default session implements it.
6. **Learn as you go** — after significant work, accept a `learning-opportunities` exercise; run `/concept-explain <term>` to get details on a concept, or `/quiz` (or "quiz me on <topic>" in `baker run dcbrown`) for a concept check; see [Learning features](#learning-features).
7. **Commit** — `git commit` may surface a learning nudge: **inside** Claude Code via the `PostToolUse` hook, **outside** Claude Code via the `post-commit` hook (see [Template architecture](#template-architecture-where-things-live)).
8. **Submit** — `submit` in `baker run assignment` packages the submission; **You must complete the final steps (i.e., upload to Canvas) to complete submissions!!!**; see [Submitting work](#submitting-work).

### Common tasks cookbook

- **Day-to-day coding loop** — Shift+Tab into **Plan Mode** → ideate → approve the plan → the default session builds it → review the diff → `git commit`. See [Using the agents](#using-the-agents).
- **Submit work** — `baker run assignment` → `submit` → upload the generated zip to Canvas. See [Submitting work](#submitting-work).
- **Get unstuck** — `/concept-explain <term>` for a definition + check; `/quiz` for a concept check; `/orient` to map an unfamiliar repo. See [Repo comprehension](#repo-comprehension) and [Learning features](#learning-features).
- **Set or update a learning goal** — `/learning-goal` (per-assignment `learning-goal.md`, team `team-goal.md`, semester `~/.config/cs3704-goals/semester-goal.md`; run it in the default session so it can write the files). See [Learning features](#learning-features).

## Learning features

The template includes learning-focused skills designed to help you build genuine expertise while using AI — not just ship code.

- **learning-opportunities** — after significant work (new files, refactors, design decisions), you may be offered a short 10–15 minute exercise on the code you just wrote. The git hook can also surface these automatically. These are optional to complete
- **quiz** — occasional concept checks on course material will be provided as pop quiz during agent sessions. These are limited to one auto-triggered quiz per session, which is mandatory for completion but not graded on correctness. You can also trigger as many quizzes as you would like to further study course content.
- **learning-goal** — set a concrete learning goal and work toward it. This will be done at the semester level, individual assignment level, and when applicable, for team or partner-based assignments.
- **concept-explain** — get a brief definition of a software‑engineering concept that belongs to the CS‑3704 curriculum (e.g., "Agile", "Use cases", etc.) with a short knowledge‑check. Explanations are grounded in the course's lecture slides (`resources/lectures/*.pdf` in the Course repo) when available, falling back to a concise local blurb when they are not. Valid concepts are those listed in `.claude/topics/allowed-concepts.txt`, automatically extracted from `Course/README.md`, or covered by a lecture deck. Additional slide‑summary markdown files placed locally in `.claude/topics/` are also accepted. Answers, questions, and the lecture source used are recorded in a dedicated `concept-explain-log.jsonl` file and do **not** count toward the automatic quiz budget.

Your learning activity (including quizzes, learning‑goals, and concept‑explain interactions) is logged to `learning-log.jsonl` and `teacher-log.jsonl` at the repo root (both git‑ignored). Concept‑explain specific entries are written to `concept‑explain-log.jsonl`; attempts to ask unrelated concepts generate a `concept‑explain‑reject` entry (manual trigger) and do **not** count toward the quiz‑budget. These logs drive the quiz budget, help you track progress, and are used by teaching staff for grading. See `CLAUDE.md` for the full policy.

## Repo comprehension

New to a codebase? Run the `orient` skill to generate an `orientation.md` that maps the repo's structure, key files, and concepts, plus two starter exercises:

```
/orient
```

It writes to `.claude/skills/learning-opportunities/resources/orientation.md` and you can re-run it anytime as the codebase evolves.

## Models

`.claude/scripts/arc-claude.sh` points Claude Code at the **ARC** LLM API (Virginia Tech's Anthropic-compatible endpoint, `https://llm-api.arc.vt.edu/api/`) using your `ARC_API_KEY`. The models available are:

| Model | ID | Context |
|-------|----|---------|
| DeepSeek-V4.1-Flash (default) | `DeepSeek-V4.1-Flash` | 512K |
| GPT-OSS 120B | `gpt-oss-120b` | 128K |
| GLM-5.3 | `GLM-5.3` | 128K |

ARC also serves reasoning variants of these models: `DeepSeek-V4.1-Flash-thinking-low`, `DeepSeek-V4.1-Flash-thinking-max`, `gpt-oss-120b-thinking-low`, `gpt-oss-120b-thinking-high`, and `GLM-5.3-thinking-high`. They are slower but can be better for planning and design. Claude Code doesn't recognize ARC model names, so it assumes a 200K-token context window and compacts the conversation at that point.

Switch models:

- **At launch:** `ARC_MODEL=GLM-5.3 baker run claude`, or `.claude/scripts/arc-claude.sh --model gpt-oss-120b`.
- **In a session:** `/model gpt-oss-120b`.

The launcher also sets `CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192` and `API_TIMEOUT_MS=600000` (10 minutes, since ARC responses can be slow), and points Claude Code's background "Haiku" model at your chosen ARC model. You must be on the VT network or VPN.

## Auto-generated files

As you work, several files appear at the repo root. All are gitignored — you don't need to manage them:

| File | What it is |
|------|------------|
| `teacher-log.jsonl` | Quiz history (drives the quiz budget). |
| `learning-log.jsonl` | Learning exercises and goals. |
| `learning-goal.md`, `team-goal.md` | Per-assignment and team learning goals. |
| `ai_disclosure.md` | Disclose AI usage for assignment. |
| `cs3704-submission-*.zip` | Packaged submissions (from `submit`), including your Claude Code session transcripts. |

## Submitting work

Use the `submit` skill (start `baker run assignment` and ask it to "submit my work", or run the appropriate submission script in `.claude/scripts/submit-*.sh` directly). It writes a session summary and packages your work for submission to Canvas or GitHub. The **`assignment`** agent can automatically verify your work meets the submission criteria: start `baker run assignment` and type `validate`.

### AI‑usage declaration (mandatory)
When you run `submit` in the assignment agent, it will ask you **five mandatory questions** (one at a time; type your answer) about any AI assistance you used for the assignment:

1. **Which AI tools (other than Claude Code) did you use?**
2. **What model names were used?**
3. **For what purposes (code generation, debugging, documentation, etc.)?**
4. **Approximate proportion of AI‑generated vs. human‑written content?**
5. **Any other disclosures required by the AI policy?**

Your answers are automatically written to a file named **`ai_disclosure.md`** at the project root. Each submission prepends a new section with a timestamped heading (`# AI Policy Summary – <date‑time UTC>`) so the file preserves a complete audit trail of all disclosures throughout the semester. `ai_disclosure.md` is included in the repo to submit for assignments (e.g., upload on Canvas, etc.), so the instructor can review your AI‑usage declarations alongside your code and session transcripts.

## Course information

- **Schedule, topics, deadlines:** the canonical course repo `https://github.com/CS3704-VT/Course` ([`README.md`](https://github.com/CS3704-VT/Course/blob/main/README.md)).
- **Policies, grading, learning outcomes:** [`SYLLABUS.md`](https://github.com/CS3704-VT/Course/blob/main/SYLLABUS.md) in that repo.
- **AI policy:** [`AI_POLICY.md`](https://github.com/CS3704-VT/Course/blob/main/AI_POLICY.md) in that repo. Use the course AI configuration; disclose meaningful AI use; you are responsible for everything you submit.
- **Questions:** for course-related questions ask the **`dcbrown`** agent (`baker run dcbrown`), for assignment-related questions ask the **`assignment`** agent (`baker run assignment`), or email Dr. Brown at dcbrown@vt.edu for questions related to these or anything else (e.g., grades, deadlines, or academic integrity).
