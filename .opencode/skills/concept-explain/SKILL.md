---
name: concept-explain
description: Provides a brief definition of a software‑engineering concept and follows it with a short interactive knowledge‑check (2‑3 questions). Designed for on‑demand student requests or automatic teachable‑moment triggers.
license: CC-BY-4.0
---

# Concept‑Explain Skill

## How it works (for agents that load this skill)
1. **Input** – The invoking agent must supply a `concept` name (e.g., "Agile", "Waterfall", "SDLC‑Requirements").
2. **Load the resource** – Read the markdown file `resources/<concept>.md` (case‑sensitive) which contains a concise 2‑3 sentence description.
3. **Display** – Show the description to the student (plain text, no formatting needed beyond what is in the resource file).
4. **Interactive check** – Ask **2‑3** follow‑up questions using the `question` tool. The questions should probe understanding of the definition (e.g., "When would you choose Agile over Waterfall?", "What phase of the SDLC follows implementation?").
5. **Logging** – Each question is logged to `teacher-log.jsonl` with a distinct `quiz_id` for the whole concept‑explain session and a `log` value of `concept-explain`. Include the `concept` field so analytics can filter by concept.
6. **Budget** – Because the interaction uses the quiz‑type budget, it counts against the automatic‑quiz limit (2 per session). Agents should check the budget before invoking (the existing budget logic inspects `teacher‑log.jsonl`).

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