---
name: concept-explain
description: Provides a brief definition of a software‑engineering concept and follows it with a short interactive knowledge‑check (2‑3 questions). Designed for on‑demand student requests or automatic teachable‑moment triggers.
license: CC-BY-4.0
---

# Concept‑Explain Skill

## How it works (for agents that load this skill)
1. **Input** – The invoking agent must supply a `concept` name that appears in the CS‑3704 curriculum. Valid concepts are those listed in `.opencode/topics/allowed-concepts.txt`, concepts extracted automatically from the official Course schedule (`Course/README.md`), **or** the first markdown heading of any slide file located in the external repository `Course/resources/slides/`. Additionally, any slide‑summary markdown files placed locally in `.opencode/topics/` (one heading per file) are also considered valid.
2. **Load the resource** – Read the markdown file `resources/<concept>.md` (case‑sensitive) which contains a concise 2‑3 sentence description.
3. **Display** – Show the description to the student (plain text, no formatting needed beyond what is in the resource file).
4. **Interactive check** – Ask **2‑3** follow‑up questions using the `question` tool. The questions should probe understanding of the definition (e.g., "When would you choose Agile over Waterfall?", "What phase of the SDLC follows implementation?").
5. **Logging** – Each question is logged to a dedicated file `concept-explain-log.jsonl` (located at the repository root). The entry includes a unique `quiz_id` for the whole concept‑explain session, a `log` value of `concept-explain`, the `concept` field, the question text, and the student's answer. A single summary entry is also written to `teacher‑log.jsonl` with `trigger: "manual"` (so it does **not** count toward the automatic‑quiz budget).
6. **Budget** – The concept‑explain interaction writes a manual entry to `teacher‑log.jsonl` (trigger: "manual"), so it does **not** consume the automatic‑quiz budget. Agents may still check the budget if they wish, but the manual entry is ignored by the budget‑checking logic.

## Example workflow (pseudocode for the agent)
```
skill({name: "concept-explain"})
concept = "Agile"
content = read("resources/" + concept + ".md")
// show description
question({questions:[{question: content, header: "Definition of " + concept, options: []}]})
// ask follow‑up questions
question({questions:[{question: "When is Agile most appropriate?", header: "Agile suitability", options: []}]})
question({questions:[{question: "What is a key ceremony in Scrum?", header: "Scrum ceremony", options: []}]})
```

## When to invoke
- **Student‑initiated**: The student asks an agent “Explain Agile” or “What is the SDLC?” – the agent loads this skill with the appropriate concept name.
- **Automatic teachable moments**: After a student creates a new artifact that belongs to a particular SDLC phase (e.g., a requirements document), the owning agent (`@requirements`) can automatically call this skill with the matching concept (e.g., `SDLC‑Requirements`).

## Resources
The skill expects a file for each concept under `resources/`. If a requested file is missing, the agent should reply:
> "I don’t have a ready definition for that concept yet; let me know another term you’d like explained."

---

*Generated for the CS‑3704 course; licensed under CC‑BY‑4.0.*