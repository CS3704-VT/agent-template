<!--
Template: UML use case diagram, ASCII notation.
Producer: @requirements-analyst, via the `analysis` skill.
Consumer:  read this file and follow the notation; replace every [placeholder].
Output:    returned as text; build/the parent agent writes it (suggested:
           docs/requirements/<name>-use-case-diagram.md).
Constraint: ASCII/text only — do NOT attempt to render an image.
-->

# Use Case Diagram: [product_name]

## Diagram

```
        [ Primary Actor ]                        [ Supporting Actor ]
               |                                         |
               |                                         |
   +-----------|-----------------------------------------|-----------+
   |           v                                         v           |
   |     ( [Use Case A] )                        ( [Use Case B] )    |
   |           |                                                     |
   |           | <<include>>                                         |
   |           v                                                     |
   |     ( [Use Case C] )        ( [Use Case D] )                    |
   |                                   ^                             |
   |                                   | <<extend>>                  |
   |                             ( [Use Case E] )                    |
   +-----------------------------------------------------------------+
```

## Notation
- `( ... )` — use case
- `[ ... ]` — actor (place primary actors on the left, supporting actors on the right)
- outer box — system boundary
- solid line — association: the actor participates in that use case
- dashed arrow labeled `<<include>>` — the including use case always performs the included one
- dashed arrow labeled `<<extend>>` — the extending use case runs only under a stated condition

## Use cases shown
| ID | Use case | Actor(s) | Notes |
|----|----------|----------|-------|
| UC-001 | [name] | [actor] | [include/extend relations, triggers] |

<!-- Keep the diagram and the table consistent. Multiple diagrams are fine
     (one per subsystem) — label each with a heading. -->
