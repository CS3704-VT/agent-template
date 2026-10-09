# CS3704 — Agent Template

This repository configures [Codex CLI](https://developers.openai.com/codex/cli) with course-specific agents, skills, and helper scripts for CS3704 with Dr. Chris Brown.

## Quick Start:

To use this template, you will need [git](https://git-scm.com/install/), [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm?ref=meilisearch-blog), and an ARC_API_KEY [environment variable](https://chlee.co/how-to-setup-environment-variables-for-windows-mac-and-linux/) set to your [API key from Virginia Tech's Advanced Research Computing](https://www.docs.arc.vt.edu/ai/011_llm_api_arc_vt_edu.html#llm-api-arc-vt-edu).


### First Time:

```sh
git clone https://github.com/CS3704-VT/agent-template   # clone this repository
cd agent-template                                       # navigate into the project directory
baker check CS3704-VT/profiles:agent-template.yml       # ensures you have necessary dependencies; verification will not be complete until after the next steps
baker bake .                                            # installs dependencies and configurations for this repo; defaults to your local machine
baker run setup                                         # runs setup scripts for starting the agent-template
```

For subsequent usage, just navigate into the top-level of the project repository and run `codex` to access the agents and skills for your assignment.

### Basic Workflow:

* The top-level Codex session acts as the `build` agent: it can generate code, tests, etc. with full access to edit files. For brainstorming and ideation without edits, switch to plan mode or ask for the `plan` agent.
* Ask for subagents by name; Codex spawns them for you.
    * The **`dcbrown`** agent answers questions about the course, explains course content, and generates quizzes.
    * The **`assignment`** agent analyzes assignment requirements (<code>have the <strong>assignment</strong> agent analyze PM1.2</code> or <code>…analyze &lt;link&gt;</code>), verifies your work (<code>have the <strong>assignment</strong> agent validate my work</code>), and packages your submission (<code>have the <strong>assignment</strong> agent submit</code>).
    * More subagents will be introduced as the semester goes on (see [PHASE.md](./PHASE.md)).
* To use skills, type `$` and pick one (e.g. `$learning-goal`), or run `/skills`.
    * To modify your course, assignment, or team learning goals, use `$learning-goal` (should be invoked automatically when beginning an assignment).
    * If you would like to generate a quiz or ask a question about a concept, use the `quiz` or `concept-explain` skills. Any agent can also invoke these skills (e.g., <code>have the <strong>dcbrown</strong> agent quiz me</code> or <code>$concept-explain Agile</code>)
    * For more in-depth learning opportunities, use `$learning-opportunities` (should be invoked automatically during development work).
* To submit, use prompts like "<code>have the <strong>assignment</strong> agent submit my work</code>" to package your work into the appropriate format (i.e., zip file, GitHub repo, etc.). **You are responsible for checking the generated requirements (the per-assignment `<name>.md` files, e.g. `PM1.2.md`) meet the assignment expectations and uploading the generated package to Canvas to complete the submission!**

**Full setup and usage guide:** [`docs/STUDENT_GUIDE.md`](docs/STUDENT_GUIDE.md).