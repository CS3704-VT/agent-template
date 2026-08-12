# CS3704 — Agent Template

This repository configures [Opencode](https://opencode.ai/) with course-specific agents, skills, and helper scripts for CS3704 with Dr. Chris Brown.

## Quick Start:

### First time:
```sh
git clone https://github.com/CS3704-VT/agent-template   # clone this repository
cd agent template                                       # navigate into the project directory
baker check CS3704-VT/profiles:agent-template.yml       # ensures you have necessary dependencies; some failing checks may be installed in the next step
baker bake .                                            # installs dependencies and configurations for this repo; defaults to your local machine
baker run setup                                         # runs setup scripts and takes you through learning goals activity for the given assignment
```

For subsequent usage, just navigate into the top-level of the project repository and run `opencode` to access the agents and skills for your assignment.

### Basic Workflow:

* Use <tab> to switch between agents. 
    * `Plan` is for brainstorming and ideation and cannot edit files.
    * `Build` can generate code, tests, etc. with full access to edit files.
    * More agents will be introduced as the semester goes on (see [PHASES.md](./PHASES.md)).
* Use **`@`** to invoke any subagents.
    * **`@dcbrown`** to answer questions about the course, explain course content, and generate quizzes.
    * **`@assignment`** to analyze assignment requirements, verify your work, and package your submission.
    * More subagents will be introduced as the semester goes on (see [PHASES.md](./PHASES.md)).
* To use skills, type `/skills` and select the appropriate skill.
    * To modify your course, assignment, or team learning goals, use `learning-goals` (should be invoked automatically when beginning an assignment).
    * If you would like to generate a quiz or ask a question about a concept, use the `quiz` or `concept-explain` skills. Any sub-agent can also invoke these skills (e.g., <code><strong>@dcbrown</strong> quiz me</code> or <code><strong>@dcbrown</strong> explain Agile</code>)
    * For more in-depth learning opportunities, use `learning-opportunities` (should be invoked automatically during development work).
* To submit, use prompts similar to <code><strong>@assignment</strong> submit</code> or <code><strong>@assignment</strong> submit my work</code>. This will package your work into the appropriate format (i.e., zip file, GitHub repo, etc.). **You must upload the generated package to Canvas to complete the submission**!

**Full setup and usage guide:** [`docs/STUDENT_GUIDE.md`](docs/STUDENT_GUIDE.md).

> **For your submission, replace this README with a README specific to your assignment.** The template guide will stay at `docs/STUDENT_GUIDE.md` and this README is copied in `docs/README.md`.
