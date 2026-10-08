# CS3704 — Agent Template

This repository configures [Claude Code](https://code.claude.com/) — running on Virginia Tech's ARC models — with course-specific agents, skills, and helper scripts for CS3704 with Dr. Chris Brown.

## Quick Start:

To use this template, you will need [git](https://git-scm.com/install/), [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm?ref=meilisearch-blog), [Claude Code](https://code.claude.com/docs/en/setup) (installed for you by `baker bake`), and an ARC_API_KEY [environment variable](https://chlee.co/how-to-setup-environment-variables-for-windows-mac-and-linux/) set to your [API key from Virginia Tech's Advanced Research Computing](https://www.docs.arc.vt.edu/ai/011_llm_api_arc_vt_edu.html#llm-api-arc-vt-edu).

> **Disclaimer:** To use this template with ARC, you must be within the Virginia Tech network (on campus or VPN). Do _not_ share your API key!


### Setup:

```sh
git clone https://github.com/CS3704-VT/agent-template   # clone this repository
cd agent-template                                       # navigate into the project directory
baker check CS3704-VT/profiles:agent-template.yml       # ensures you have necessary dependencies; verification will not be complete until after the next steps
baker bake .                                            # installs dependencies and configurations for this repo; defaults to your local machine
baker run setup                                         # runs setup scripts for starting the agent-template
```

### First Time:

After the initial installation and setup, run the following in the root directory of the repository _for each assignment_:

```sh
baker run assignment   # then type: analyze <assignment name or link>  — integrates assignment details into repository context
/learning-goal         # (inside the session) sets the learning goals for the given scope (course, assignment, or team)
```

The first launch asks whether you trust this folder and whether to use the API key from your environment — answer **Yes** to both (it is your ARC key). For subsequent usage, just navigate into the top-level directory of the project repository and run `baker run claude` (or `baker run <agent>`) to access the agents and skills for your assignment.

### Basic Workflow:

* Every session starts through ARC with `baker run <name>` (or `.claude/scripts/arc-claude.sh`). **Bare `claude` does not use ARC.**
* `baker run claude` starts the **default session** — it generates code, tests, etc. with full access to edit files.
    * Press **Shift+Tab** to toggle **Plan Mode** for brainstorming and ideation (no file edits).
* Each course agent is its own conversation — start it with `baker run <short name>`, and come back to an earlier one with `.claude/scripts/arc-claude.sh --agent <name> --resume`:
    * **`baker run dcbrown`** to answer questions about the course, explain course content, and generate quizzes.
    * **`baker run assignment`** to analyze assignment requirements (`analyze PM1.2` or `analyze <link>`), verify your work (`validate`), and package your submission (`submit`).
    * More agents will be introduced as the semester goes on (see [PHASE.md](./PHASE.md)). When you ask an agent for work that belongs to another role, it tells you which agent to start.
* To use skills, type `/` and pick the skill (e.g. `/learning-goal`, `/quiz`, `/concept-explain Agile`).
    * To modify your course, assignment, or team learning goals, use `/learning-goal` (should be invoked automatically when beginning an assignment).
    * If you would like to generate a quiz or ask a question about a concept, use the `quiz` or `concept-explain` skills. Any agent can also run these skills (e.g., in `baker run dcbrown`: "quiz me" or "explain Agile").
    * For more in-depth learning opportunities, use `/learning-opportunities` (should be invoked automatically during development work).
* To submit, start `baker run assignment` and ask it to "submit" or "submit my work" to package your work into the appropriate format (i.e., zip file, GitHub repo, etc.). **You are responsible for checking the generated requirements (the per-assignment `<name>.md` files, e.g. `PM1.2.md`) meet the assignment expectations and uploading the generated package to Canvas to complete the submission!**

**Full setup and usage guide:** [`docs/STUDENT_GUIDE.md`](docs/STUDENT_GUIDE.md).

> **For your submission, replace this README with a README specific to your assignment.** The template guide will stay at `docs/STUDENT_GUIDE.md` and this README is copied in `docs/README.md`.
