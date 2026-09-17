# Templates

This directory provides templates to use as a basis for agent-generated artifacts. The following templates are provided:

* [`assignment.md`](./assignment.md): Template for integrating assignment details into the agentic framework, creating a file in the root directory for the given assignment (e.g., `HW1.md`). This file is generated using <code><strong>@assignment</strong> analyze HW1</code> and used by <code><strong>@assignment</strong> verify</code> and <code><strong>@assignment</strong> submit</code>.

Requirements & design artifacts (read by the phase-2 agents; the agents return content and `build`/the parent writes it):

* [`use-case.md`](./use-case.md): Text use case (actor, scenario, pre/postconditions, main/sub/alternate flows, `UC-###` IDs). Used by <code><strong>@requirements-analyst</strong></code> via the <code>analysis</code> skill.
* [`user-story.md`](./user-story.md): User story (`As a … I want … so that …`) with Given/When/Then acceptance criteria and MoSCoW priority. Used by <code><strong>@requirements-analyst</strong></code>.
* [`use-case-diagram.md`](./use-case-diagram.md): UML use-case diagram, ASCII notation (actors, system boundary, use-case ovals, <code>&lt;&lt;include&gt;&gt;</code>/<code>&lt;&lt;extend&gt;&gt;</code>). Used by <code><strong>@requirements-analyst</strong></code>.
* [`sequence-diagram.md`](./sequence-diagram.md): ASCII sequence diagram (participants, lifelines, activations, numbered messages, alt/opt frames). Used by <code><strong>@requirements-analyst</strong></code>.
* [`class-diagram.md`](./class-diagram.md): ASCII UML class diagram (visibility, attributes/operations, relationships, multiplicities). Used by <code><strong>@system-architect</strong></code>.
* [`data-model.md`](./data-model.md): ER-based data model (ASCII entity-relationship diagram + entity/relationship/relational-schema tables). Used by <code><strong>@system-architect</strong></code>.
* [`adr.md`](./adr.md): Architectural Decision Record (title, status, context, decision, consequences, alternatives); one decision per record. Used by <code><strong>@system-architect</strong></code>.
