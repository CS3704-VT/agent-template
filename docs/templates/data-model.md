<!--
Template: data model / entity-relationship diagram (ASCII).
Producer: @system-architect.
Consumer:  read and follow; replace every [placeholder].
Output:    returned as text; build/the parent writes it (suggested:
           docs/design/<name>-data-model.md).
Constraint: ASCII/text only — do NOT attempt to render an image.
-->

# Data Model: [subsystem / product_name]

## ER Diagram

```
   +------------------+            +------------------+
   |      [User]      |            |     [Order]      |
   +------------------+            +------------------+
   | PK id            |1          *| PK id            |
   |    email         |------------| FK user_id       |
   |    name          |            |    placed_at     |
   +------------------+            +------------------+
                                          | 1
                                          | *
                                   +------------------+
                                   |   [OrderItem]    |
                                   +------------------+
                                   | PK id            |
                                   | FK order_id      |
                                   |    quantity      |
                                   +------------------+
```

## Notation
- `+----+` box — entity
- `PK` / `FK` — primary key / foreign key
- `1`, `*`, `0..1` at a line end — cardinality (e.g. one-to-many, optional)
- a line between entities is a relationship; name it in the Relationships table

## Entities
| Entity | Purpose | Key attributes |
|--------|---------|----------------|
| [User] | [what it represents] | id (PK), email, name |

## Relationships
| Relationship | Entities | Cardinality | Description |
|--------------|----------|-------------|-------------|
| [places] | [User]–[Order] | 1..* | [one user places zero or more orders] |

## Relational Schema
| Table | Column | Type | Key / constraint |
|-------|--------|------|------------------|
| [user] | id | [UUID] | PK |
| [user] | email | [text] | unique, not null |
| [order] | user_id | [UUID] | FK → user.id |

<!-- Keep the diagram, entity/relationship tables, and schema consistent.
     Split large models into one diagram per bounded context and label each. -->
