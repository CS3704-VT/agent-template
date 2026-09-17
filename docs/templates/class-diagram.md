<!--
Template: UML class diagram, ASCII notation (low-level design).
Producer: @system-architect.
Consumer:  read this file and follow the notation; replace every [placeholder].
Output:    returned as text; build/the parent agent writes it (suggested:
           docs/design/<name>-class-diagram.md).
Constraint: ASCII/text only — do NOT attempt to render an image.
-->

# Class Diagram: [subsystem / product_name]

## Diagram

```
   +-----------------------------+
   |           [Order]           |
   +-----------------------------+
   | - id: String                |
   | - placedAt: Date            |
   | - lines: List<[OrderLine]>  |
   +-----------------------------+
   | + total(): Money            |
   | + addLine(item, qty): void  |
   +-----------------------------+
              | 1
              |  *
              v
   +-----------------------------+
   |         [OrderLine]         |
   +-----------------------------+
   | - quantity: int             |
   | - unitPrice: Money          |
   +-----------------------------+
   | + subtotal(): Money         |
   +-----------------------------+
```

## Class box notation
- three compartments: class name, attributes, operations
- visibility prefix: `+` public, `-` private, `#` protected, `~` package
- attribute form: `name: Type`; operation form: `name(params): ReturnType`

## Relationship notation
- `--|>` — generalization / inheritance (arrow points to the superclass)
- `-->` — directed association
- `--`  — undirected association
- `o--` — aggregation (open diamond at the whole)
- `*--` — composition (filled diamond at the whole)
- `..>` — dependency
- label each end with a multiplicity (`1`, `0..1`, `*`, `1..*`) and, where useful, a role name

## Classes
| Class | Responsibility | Key relationships |
|-------|----------------|-------------------|
| [Order] | [what it knows/does] | [1..* lines → OrderLine (composition)] |

<!-- Keep the diagram and the table consistent. Split large systems into one
     diagram per subsystem or layer and label each with a heading. -->
