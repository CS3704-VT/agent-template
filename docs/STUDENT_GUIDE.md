# CS3704 — Student Guide to the Agent Template

This repository is your **agentic development environment** for CS3704 (Intermediate Software Design and Engineering). It configures [Opencode](https://opencode.ai/) with course-specific agents, skills, and helper scripts you will use all semester.

## What's inside

| Path | Purpose |
|------|---------|
| `AGENTS.md` | Shared instructions every agent follows (policy, logging, budgets). Worth reading once. |
| `PHASE.md` | Which agents are live this phase, and the roadmap of what arrives next. **Check this first.** |
| `.opencode/agents/*.md` | The course agents. The baseline available agents are **Plan** (for planning), **Build** (for coding), **`@dcbrown`** (for course administration), and **`@assignment`** (for assignment requirements and packaging). The available agents will grow with each phase — see `PHASE.md`. |
| `.opencode/skills/*` | On-demand capabilities: `quiz`, `concept-explain`, `learning-goal`, `learning-opportunities`, `orient`, `submit`. |
| `.opencode/scripts/` | Helper scripts: `post-tool-use.sh` (learning nudges) and `submit.sh` (submission packaging). |
| `hooks/`, `setup.sh` | Git-hook infrastructure. `setup.sh` installs the hooks into `.git/hooks/`. |
| `docs/templates/` | Starter templates for course artifacts. |
| `opencode.json` | Provider and model configuration. |

## Template architecture (where things live)

The template is organized so that course-owned configuration can live alongside your own project/assignment files. Here's the layout:

```
agent-template/
├── README.md            # landing page + quick start (replace with your project README later)
├── AGENTS.md            # shared policy every agent follows — read once
├── PHASE.md             # course-owned; which agents are live this phase
├── opencode.json        # ARC provider + models; reads ARC_API_KEY from env
├── HW1.md / PM1.1.md     # per-assignment details, one file per assignment, created by @assignment analyze
├── .gitignore           # ignores logs, goals, zips, .env, runtime deps, .tmp/
├── docs/                # this guide + starter templates
│   ├── README.md
│   ├── STUDENT_GUIDE.md
│   └── templates/
│       └── assignment.md   # seed for @assignment analyze (copied to <name>.md at repo root)
├── hooks/               # git-hook sources
│   ├── pre-commit       # on commit, calls .opencode/scripts/post-tool-use.sh
│   └── setup-git-hooks.sh  # copies hooks into .git/hooks/
└── .opencode/           # opencode config home
    ├── agents/*.md      # one file per agent (build, plan, dcbrown, …)
    ├── skills/<name>/SKILL.md   # on-demand capabilities (quiz, concept-explain, …)
    ├── scripts/         # post-tool-use.sh (learning nudges), submit.sh (packaging)
    └── topics/          # reserved, currently empty
```

### Template Editing

- **Course-owned (extend, don't edit):** Please do not edit `AGENTS.md`, `PHASE.md`, `.opencode/agents/*`, `.opencode/skills/*`, `.opencode/scripts/*`, `docs/STUDENT_GUIDE.md`, `opencode.json`, or other files critical for configuring and using this template. Please also do not modify the auto-generated files, such as logs, goal files, and submission zips — see [Auto-generated files](#auto-generated-files).
- **Yours to edit:** You may edit your project code and documentation and the per-assignment analysis files (e.g. `HW1.md`, `PM1.1.md`) to include/modify assignment requirements.
- **If you find an issue with this template, please contact Dr. Brown or submit a pull request!** 

## Getting started

1. **Set your API key.** `opencode.json` uses the **ARC** provider and reads the key from the `ARC_API_KEY` environment variable. You should be able to set it in your shell using the following commands:
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
   - The first time you run it, the script sets a git hook that surfaces the `learning-opportunities` skill automatically as you work (see [Learning features](#learning-features) below) and creates a **semester‑goal** file under `~/.config/opencode/cs3704-goals/semester-goal.md` to outline your learning goals for CS3704 this semester. 
   - On subsequent runs (once the semester goal exists), the script automatically launches the **individual learning‑goal** (`learning-goal.md`) to outline your learning goals for specific assignments. After you complete that, you will be asked whether this is a **team** assignment; answering “y” will also launch the **team learning‑goal** (`team-goal.md`), which should be completed collaboratively with your teammates for group assignments.
   - The script uses the `learning‑goal` skill to set up your goals. You can change or update your goals by using `\skills` and selecting the `learning-goal` skill (see [Learning features](#learning-features) below).
4. **Start Opencode:**
   ```sh
   cd agent-template
   opencode
   ```
   The default model is `ARC/DeepSeek-V4-Flash`. See [Models](#models) for details on available models and how to switch.

## Phases & agents

Agents are released in phases over the semester rather than all at once. **`PHASE.md` is the source of truth** for which agents are available right now — read it before reaching for an agent, because the set changes each phase.

- **Baseline (now):** `build`, `plan`, `dcbrown`, and `assignment`.
- **Later phases** add the requirements, process, architect, designer, tester, maintainer, and review agents as the course progresses.

## Using the agents

- **`build`** implements features, writes/runs tests, and refactors code. It is the primary editor.
- **`plan`** analyzes tasks and produces plans (read-only; delegates writes to build).
- **`dcbrown`** (subagent) answers course questions, runs quizzes and concept explanations.
- **`assignment`** (subagent) retrieves assignment details, verifies completion, and packages submission.

Phase-gated agents (requirements, architect, tester, etc.) arrive with their phase branch — invoke them by role once `PHASE.md` lists them as live (e.g., "<code><strong>@requirements-analyst</strong> review my user stories</code>". Your agent delegates via the Task tool.

## Workflow: a typical session

### End-to-end walkthrough

1. **One-time setup** — Set `ARC_API_KEY`, run `baker check`, `baker bake`, and `baker run` commands (see [Getting started](#getting-started)).
2. **Set a learning goal** — run `\skills` and select `learning-goal` (writes `learning-goal.md`); see [Learning features](#learning-features).
3. **Extract the assignment requirements** — run <code><strong>@assignment</strong> analyze PM1.2</code> (or pass a link: <code><strong>@assignment</strong> analyze https://…</code>) to automatically gather the details and requirements of a particular assignment. This writes a per-assignment `<name>.md` file at the repo root (e.g. `PM1.2.md` or `HW3.md`). _This will need to be manually reviewed by you!_ A bare `PMx` resolves to the project README (overview, not an assignment); an unknown name or missing file produces a graceful "no assignment found" error.
4. **Pick the right agent with `<tab>`** — `plan` for brainstorming (read-only), `build` for code/tests/edits, **`@dcbrown`** for course questions and quizzes, and **`@assignment`** for assignment details and submission. Check [PHASE.md](../PHASE.md) for phase-gated agents; see [Using the agents](#using-the-agents).
5. **Plan → Build handoff** — ideate with `plan`; when the plan is solid, have `build` implement it (Plan delegates writes to Build).
6. **Learn as you go** — after significant work, accept a `learning-opportunities` exercise; run `/concept-explain <term>` to get details on a concept, or <code><strong>@dcbrown</strong> quiz me on <topic></code> for a concept check; see [Learning features](#learning-features).
7. **Commit** — `git commit` triggers the `pre-commit` hook, which may surface a learning nudge (see [Template architecture](#template-architecture-where-things-live)).
8. **Submit** — <code><strong>@assignment</strong> submit</code> packages the submission; **You must complete the final steps (i.e., upload to Canvas) to complete submissions!!!**; see [Submitting work](#submitting-work).

### Common tasks cookbook

- **Day-to-day coding loop** — `<tab>` to **`Plan`** → ideate → delegate to **`Build`** → review the diff → `git commit`. See [Using the agents](#using-the-agents).
- **Submit work** — <code><strong>@assignment</strong> submit</code> → upload the generated zip to Canvas. See [Submitting work](#submitting-work).
- **Get unstuck** — `/skills`  → `concept-explain <term>` for a definition + check; <code><strong>@dcbrown</strong> quiz me on <topic></code> for a concept check; `/orient` to map an unfamiliar repo. See [Repo comprehension](#repo-comprehension) and [Learning features](#learning-features).
- **Set or update a learning goal** — `\skills` → `learning-goal` (per-assignment `learning-goal.md`, team `team-goal.md`; the semester goal is delegated to Build). See [Learning features](#learning-features).

## Learning features

The template includes learning-focused skills designed to help you build genuine expertise while using AI — not just ship code.

- **learning-opportunities** — after significant work (new files, refactors, design decisions), you may be offered a short 10–15 minute exercise on the code you just wrote. The git hook can also surface these automatically. These are optional to complete
- **quiz** — occasional concept checks on course material will be provided as pop quiz during agent sessions. These are limited to one auto-triggered quiz per session, which is mandatory for completion but not graded on correctness. You can also trigger as many quizzes as you would like to further study course content.
- **learning-goal** — set a concrete learning goal and work toward it. This will be done at the semester level, individual assignment level, and when applicable, for team or partner-based assignments.
- **concept-explain** — get a brief definition of a software‑engineering concept that belongs to the CS‑3704 curriculum (e.g., "Agile", "Use cases", etc.) with a short knowledge‑check. Explanations are grounded in the course's lecture slides (`resources/lectures/*.pdf` in the Course repo) when available, falling back to a concise local blurb when they are not. Valid concepts are those listed in `.opencode/topics/allowed-concepts.txt`, automatically extracted from `Course/README.md`, or covered by a lecture deck. Additional slide‑summary markdown files placed locally in `.opencode/topics/` are also accepted. Answers, questions, and the lecture source used are recorded in a dedicated `concept-explain-log.jsonl` file and do **not** count toward the automatic quiz budget.

Your learning activity (including quizzes, learning‑goals, and concept‑explain interactions) is logged to `learning-log.jsonl` and `teacher‑log.jsonl` at the repo root (both git‑ignored). Concept‑explain specific entries are written to `concept‑explain‑log.jsonl`; attempts to ask unrelated concepts generate a `concept‑explain‑reject` entry (manual trigger) and do **not** count toward the quiz‑budget. These logs drive the quiz budget, help you track progress, and are used by teaching staff for grading. See `AGENTS.md` for the full policy.

## Repo comprehension

New to a codebase? Run the `orient` skill to generate an `orientation.md` that maps the repo's structure, key files, and concepts, plus two starter exercises:

```
/orient
```

It writes to `.opencode/skills/learning-opportunities/resources/orientation.md` and you can re-run it anytime as the codebase evolves.

## Models

`opencode.json` configures the **ARC** provider (Virginia Tech's LLM API) with
three models:

| Model | ID |
|-------|----|
| DeepSeek-V4-Flash | `ARC/DeepSeek-V4-Flash` |
| GPT-OSS 120B (default) | `ARC/gpt-oss-120b` |
| GLM-5.2 | `ARC/GLM-5.2` |
| Kimi-K3 | `ARC/Kimi-K3` |

You must have an API key set as an environment variable to `ARC_API_KEY`.

Switch models in the opencode interface using `/models` and navigating to the desired AI model or with `--model`. All three share a 128K-token context window.

## Auto-generated files

As you work, several files appear at the repo root. All are gitignored — you don't need to manage them:

| File | What it is |
|------|------------|
| `teacher-log.jsonl` | Quiz history (drives the quiz budget). |
| `learning-log.jsonl` | Learning exercises and goals. |
| `learning-goal.md`, `team-goal.md` | Per-assignment and team learning goals. |
| `ai_disclosure.md` | Disclose AI usage for assignment. |
| `cs3704-submission-*.zip` | Packaged submissions (from `submit`). |

## Submitting work

Use the `submit` skill (with a prompt like "<code><strong>@assignment</strong> submit my work</code>" or running the appropriate submission script in `.opencode/scripts/submit_*.sh` directly). It writes a session summary and packages your work for submission to Canvas or GitHub. The **`@assignment`** subagent can automatically verify your work meets the submission criteria with the following command: <code><strong>@assignment</strong> validate</code>

### AI‑usage declaration (mandatory)
When you run <code><strong>@assignment</strong> submit</code>, the system will ask you **five mandatory questions** about any AI assistance you used for the assignment:

1. **Which AI tools (other than Opencode) did you use?**
2. **What model names were used?**
3. **For what purposes (code generation, debugging, documentation, etc.)?**
4. **Approximate proportion of AI‑generated vs. human‑written content?**
5. **Any other disclosures required by the AI policy?**

Your answers are automatically written to a file named **`ai_disclosure.md`** at the project root. Each submission prepends a new section with a timestamped heading (`# AI Policy Summary – <date‑time UTC>`) so the file preserves a complete audit trail of all disclosures throughout the semester. `ai_disclosure.md` is included in the repo to submit for assignments (e.g., upload on Canvas, etc.), so the instructor can review your AI‑usage declarations alongside your code and session transcripts.

## Course information

- **Schedule, topics, deadlines:** the canonical course repo `https://github.com/CS3704-VT/Course` ([`README.md`](https://github.com/CS3704-VT/Course/blob/main/README.md)).
- **Policies, grading, learning outcomes:** [`SYLLABUS.md`](https://github.com/CS3704-VT/Course/blob/main/SYLLABUS.md) in that repo.
- **AI policy:** [`AI_POLICY.md`](https://github.com/CS3704-VT/Course/blob/main/AI_POLICY.md) in that repo. Use the course AI configuration; disclose meaningful AI use; you are responsible for everything you submit.
- **Questions:** for course-related questions ask the **`@dcbrown`** agent, for assignment-related questions ask the **`@assignment`** agent, or email Dr. Brown at dcbrown@vt.edu for questions related to these or anything else (e.g., grades, deadlines, or academic integrity).
