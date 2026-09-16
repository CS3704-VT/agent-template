<!--
Template: UML sequence diagram, ASCII notation.
Producer: @requirements-analyst, via the `analysis` skill.
Consumer:  read this file and follow the notation; replace every [placeholder].
Output:    returned as text; build/the parent agent writes it (suggested:
           docs/requirements/<name>-sequence-diagram.md).
Constraint: ASCII/text only — do NOT attempt to render an image.
-->

# Sequence Diagram: [use case / scenario name]

One diagram per scenario (typically the main flow of a single use case).

## Diagram

```
   [ Actor ]         [ Component :A ]        [ Component :B ]
       |                    |                       |
       |  1. [message]      |                       |
       |------------------->|                       |
       |                    |  2. [message]         |
       |                    |---------------------->|
       |                    |                       |
       |                    |  3. [return]          |
       |                    |<----------------------|
       |  4. [return]       |                       |
       |<-------------------|                       |
       |                    |                       |
```

## Notation
- header row — participants (actors and system components); give components a `:Type` suffix
- vertical line — lifeline (time flows downward)
- `|` block between two lifeline points — activation bar (the participant is executing)
- `--->` solid arrow — synchronous message / call
- `<---` / `- ->` arrow back — return message
- number every message in time order (`1.`, `2.`, ...)
- `[condition]` — guard, or wrap optional/alternative fragments in a labeled `alt`/`opt` block

## Scenario
- **Use case:** [UC-### / name]
- **Preconditions:** [state required to start]
- **Outcome:** [state on success]

## Messages
| # | From → To | Message | Kind |
|---|-----------|---------|------|
| 1 | [actor] → [:Component] | [message] | call |
| 2 | [:Component] → [:Other] | [message] | call / return |
