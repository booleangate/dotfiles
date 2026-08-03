# CLAUDE.md

## Project Overview

- Scale: always design architectures, algorithms, and data access patterns with the scale of a multinational
  conglomerate customers in mind.  The goal is to be able to support 30K parallel and unique key background workflows.

## Non-negotiables
- NEVER SACRIFICE CLARITY. Clarity is the most important feature of everything: code, documentation, architecture, etc.
- Never take short cuts.
- Never make something up to answer a question or problem you don't know how to answer.
- Always ask for help if you get stuck.
- Never be deferential, acquiesce, use platitudes, or be complimentary.
- Always be terse in your responses and  avoiding all conversational fluff
- Never change test implementations to get tests to pass unless 1) the interface to the code under test has changed and
  the test isn't compiling, or 2) the code under test has semantically changed.
- Suggest new third party code dependencies only if there is an extremely compelling reason to do so.  Simple functions
  should never require a new dependency.  New third party dependencies should be a last resort and MUST be manually
  approved.

## Workflow

### Re-orienting before fixing
- Before debugging a reported error or resuming work, run `git status` and `git diff` to establish the current
  working-tree state. Do not assume the code matches what you last wrote — it may have been edited concurrently.
- Treat "file modified externally / by a linter" notices as a trigger to **diff the whole tree not just the named file**,
  and to confirm the current design before proposing a fix.
- When the working tree has diverged from your mental model, reconcile first (read the diff, restate the intended
  design) before editing.

## Tech Stack

- **Backend**: React, Typescript, Jest, Apollo (for GraphQL)
- **Frontend**: React, TypeScript, Vitest
- **APIs**: GraphQL for frontend, REST for external customers.
- **Databases**: MongoDB (primary DB, most use cases), Postgresql (light use)
- **AI**: Claude, Cursor, Codex

## Common Commands

Most commonly used commands:
- Source control:
  - `git`
  - `gh stack` for stacking PRs
 
### Primary success criteria: Simplicity
Systems must be designed and code must be written to prioritize clarity, simplicity, and long term maintainability.
If anyone of these dimensions is not satisfied, you've written bad code and have failed.

- Simplicity is a prerequisite for reliability.
- Simple != easy.  Do not conflate or confuse the two.  "Easy" means "to be at hand", "to be approachable". "Simple" is
  the opposite of "complex" which means "being intertwined", "being tied together".
- What matters in software is: does the software do what is supposed to do? Is it of high quality? Can we rely on it?
  Can problems be fixed along the way? Can requirements change over time? The answers to these questions is what matters
  in writing software not the look and feel of the experience writing the code or the cultural implications of it.
- The benefits of simplicity are: ease of understanding, ease of change, ease of debugging, flexibility.
- Complex constructs: State, Methods, Syntax, Inheritance, Switch/matching, Actors, ORM, Conditionals.
- Simple constructs: Types, Values, Functions, Namespaces, Data, Polymorphism, Queues, Declarative data manipulation, Rules, Consistency.
- Build simple systems by: 
  - Abstracting - design by answering questions related to what, who, when, where, why, and how.
  - Choosing constructs that generate simple artifacts.
  - Simplify by encapsulation.

## Architecture
- Prefer following existing code and system architectural patterns that follow industry best practices and standards.
- For coding architecture, if no adequate pattern is found, then prefer a hexagonal approach but using a naming scheme
  that is similar to those already found at large in the repo.

## Code Style

### Prefer the Go approach to programming when possible:
- Don't communicate by sharing memory, share memory by communicating.
- The bigger the interface, the weaker the abstraction.
- Make the zero value useful.
- A little copying is better than a little dependency.
- Clear is better than clever.
- Errors are values.
- Don't just check errors, handle them gracefully.
- Design the architecture, name the components, document the details.
- Documentation is for users.
- Avoid throwing errors; handle them if possible.  Using the Results pattern is better than throwing, especially within
  a service's implementation.

### Other equally important guidelines:
- Infra dependencies (e.g. database connection, external integrations, etc) don't count as state.
- Avoid using classes as stateful components.
- Strongly prefer to use dependency injection in services.  If an interface for that service doesn't exist, create one
  that is as narrow as possible for the use cases within the service.
- Prefer to inject mock dependencies into a service class rather than trying to mock/spy on its internally defined
  dependencies.
- Do not attempt to refactor existing code unless the addition/fix being applied lowers simplicity or clarity.
- Follow the style of the surround code before applying our own style preferences.
- Strongly prefer arrow functions over function declarations.
- Always push helper functions lower down the page.  Global constants (exported or not), exported types and exported
  functions - in that order - should come first on the page.
- Only use a `class` or `function` declaration if absolutely necessary or if it follows a well established patter.  Prefer
  simple objects and arrow functions.
- Prefer POJOs implementing an interface rather than a class.
- You must define interfaces where they are consumed unless an interface is truly shared by multiple production code
  consumers (tests don't count).
- Always separate imports for values and types.  Example:
	```
	import { someFunction } from "some-package";
	import type { SomeType } from "some-package";
	```
- Organize file contents so that they're generally readable top-down and in
  these sections.  Configuration, exports, entry points are the most important
  things at the top.
  - Sections:
    1. Imports
    2. Global consts, especially when they're some kind of configuration or used
       broadly.  If it's something more static (e.g. a cache key prefix that
       shouldn't change and is a const for consistency), then define it closer
       to where its used (e.g. near the functions that use it).
    3. Exports: types then functions/classes.
    4. Helper functions.
  - Group things in the same section by purpose, but still try to be top-down.
- Avoid stutters in object/property names.  For example, `tracker.setDuration()` not `tracker.trackDuration()`.


### Code comments:
- Aside from documentation, especially for types and service interfaces, the code should speak for itself and comments
  generally shouldn't be needed.
- Comments must never explain what the code does. The code itself should.
- Comments must be written for an audience of highly experienced engineers.  Do not include more
  than what is strictly need.
- Comments should explain why something exists, and why it exists in that way.  For example, adding context or explaining
  a system level nuance
- If the comment cannot be simply stated, the code is probably too clever or unclear and it should be refactored
  (ESPECIALLY for new code).
- Examples of when to add comments:
    - Explain the quirks of internal or external systems that are necessary to understand the code.
    - Explain which parts of the system are Legacy.
    - Explain when legacy code or feature flag gates can be removed (leave a "after X is done" or a date whenever
      possible).
    - Explain any hacks/shortcuts/cleverness you needed to do and why they work -- BUT remember that this kind of code
      should be avoided as much as possible.
    - Explain the internal interdependencies that arent explicit (eg other systems relying on structure or api).
    - Be ok with writing one or more  paragraphs whenever needed.
    - Never rely solely on external documentation. Provide a link to that documentation if available, but you must also
      provide inline documentation.
