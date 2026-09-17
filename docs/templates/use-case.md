<!--
Template: text use case for CS3704 requirements analysis.
Producer: @requirements-analyst, via the `analysis` skill.
Consumer:  read this file and follow its structure; replace every [placeholder].
Output:    the producing agent RETURNS the filled content. Phase-2 agents are
           read-only — build/the parent agent writes the artifact (suggested
           location: docs/requirements/<name>-use-cases.md).
Rules:     number each use case UC-001, UC-002, ...; keep it specific,
           measurable, and testable; repeat the UC block per use case.
-->

# Requirements Analysis: [product_name]

## UC-### — [use case goal]

**Actor:** [something with behavior that interacts with the system — user, external system, organization, ...]

**Scenario:** [one specific sequence of interactions between the actor and the system that achieves a goal]

**Preconditions:** [noteworthy system/environment state required before the use case can start — not "the user has power"]

**Postconditions:** [noteworthy state guaranteed after successful completion]

### Main Flow
- [S1] [step-by-step interaction — actor action or system response]
- [S2] [step-by-step interaction]

### Alternative Flows
- [E1] [variation or error case and how the system reacts; state where it rejoins the main flow, e.g. "returns to S3"]

<!-- Repeat the "## UC-###" block for each use case. -->
