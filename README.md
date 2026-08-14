# CS3704 — Agent Template

This repository configures [Opencode](https://opencode.ai/) with course-specific agents, skills, and helper scripts for CS3704 with Dr. Chris Brown.

## Quick Start:

To use this template, you will need [git](https://git-scm.com/install/), [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm?ref=meilisearch-blog), and an ARC_API_KEY [environment variable](https://chlee.co/how-to-setup-environment-variables-for-windows-mac-and-linux/) set to your [API key from Virginia Tech's Advanced Research Computing](https://www.docs.arc.vt.edu/ai/011_llm_api_arc_vt_edu.html#llm-api-arc-vt-edu).


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
opencode
@assignment analyze <assignment name or link to assignment> # Integrates assignmnt details into repository context
/skills -> /learning-goal                                   # Sets the learning goals for the given assignment scope (course, assignment, or team)
```

For subsequent usage, just navigate into the top-level directory of the project repository and run `opencode` to access the agents and skills for your assignment.

### Basic Workflow:

* Use <tab> to switch between agents. 
    * `Plan` is for brainstorming and ideation and cannot edit files.
    * `Build` can generate code, tests, etc. with full access to edit files.
    * More agents will be introduced as the semester goes on (see [PHASES.md](./PHASES.md)).
* Use **`@`** to invoke any subagents.
    * **`@dcbrown`** to answer questions about the course, explain course content, and generate quizzes.
    * **`@assignment`** to analyze assignment requirements (<code><strong>@assignment</strong> analyze PM1.2</code> or <code><strong>@assignment</strong> analyze &lt;link&gt;</code>), verify your work (<code><strong>@assignment</strong> validate</code>), and package your submission (<code><strong>@assignment</strong> submit</code>).
    * More subagents will be introduced as the semester goes on (see [PHASES.md](./PHASES.md)).
* To use skills, type `/skills` and select the approporiate skill.
    * To modify your course, assignment, or team learning goals, use `learning-goals` (should be invoked automatically when beginning an assignment).
    * If you would like to generate a quiz or ask a question about a concept, use the `quiz` or `concept-explain` skills. Any sub-agent can also invoke these skills (e.g., <code><strong>@dcbrown</strong> quiz me</code> or <code><strong>@dcbrown</strong> explain Agile</code>)
    * For more in-depth learning opportunities, use `learning-opportunities` (should be invoked automatically during development work).
* To submit, use  prompts like "<code><strong>@assignment</strong> submit</code>" or "<code><strong>@assignment</strong> submit my work</code>" to package your work into the appropriate format (i.e., zip file, GitHub repo, etc.). **You are responsible for checking the generated requirements (the per-assignment `<name>.md` files, e.g. `PM1.2.md`) meet the assignment expectations and uploading the generated package to Canvas to complete the submission!**

**Full setup and usage guide:** [`docs/STUDENT_GUIDE.md`](docs/STUDENT_GUIDE.md).

> **For your submission, replace this README with a README specific to your assignment.** The template guide will stay at `docs/STUDENT_GUIDE.md` and this README is copied in `docs/README.md`.
