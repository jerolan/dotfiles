---
name: dependency-composition
description: >
  Use when writing or refactoring any module that wires dependencies (services,
  repositories, HTTP clients, external APIs). Load this skill whenever you see
  hard-coded service imports, tangled constructor injection, DI containers, or
  code that is hard to unit-test in isolation. Applies partial application and
  explicit dependency passing instead of hidden globals or framework-heavy DI,
  keeping business logic decoupled from transport and infrastructure.
---

## Intent

Help design and refactor code toward **discrete modules** that:

- minimize _incidental coupling_
- keep business logic separate from transport (HTTP/GraphQL/etc.)
- stay easy to test without transport-aware scaffolding
- are wired via **functions and partial application** instead of framework-heavy DI

This skill is inspired by the “Dependency Composition” approach described by Daniel Somerfield. (MartinFowler.com) :contentReference[oaicite:4]{index=4}

---

## When to use me

Use this skill when you want to:

- refactor away from ad-hoc dependency wiring or DI container complexity
- introduce a consistent wiring pattern across modules
- make unit tests independent of HTTP frameworks / runtime infrastructure
- reduce cross-module type leakage

Avoid (or adapt carefully) when:

- your stack strongly favors class-based patterns and the team is not aligned
- reflection / annotation-based DI is mandatory (framework constraints)
- performance constraints require heavy shared types or global singletons

---

## Inputs I need (tell me up front)

Minimum:

- **Target boundary** (pick one): controller/handler, domain service, repository layer
- **Current pain**: tests too hard, coupling, fragile type changes, wiring sprawl, etc.
- **Language/runtime**: (e.g., TypeScript/Node, Kotlin, Go)

Helpful:

- A small code sample (1–3 files) showing current wiring
- The desired seam(s): what should be stubbed/faked in unit tests?

---

## Output you should expect

Depending on your request, I will produce:

- a **proposed module boundary map** (who calls whom, and what contracts)
- function signatures for:
  - “pure” business logic
  - dependency contracts (“ports”)
  - composition/wiring functions (“adapters”)
- a **test strategy**:
  - unit tests that stub dependencies by passing functions
  - optional integration test (“walking skeleton”) to validate wiring
- a step-by-step **refactor plan** with small, safe increments

---

## Core principles (keep these stable)

### 1) Dependency injection is a means, not an end

We optimize for qualities like:

- discrete modules with minimal incidental coupling
- business logic isolated from transport
- tests that don’t break on unrelated type additions
- few types exposed outside the module/directory :contentReference[oaicite:5]{index=5}

### 2) Prefer functions over classes for dependency contracts

Dependencies are expressed as **function parameters** (or interfaces made of functions),
not constructed internally.

### 3) Use partial application for wiring

Composition happens by creating functions that “close over” context/dependencies:

- `makeHandler(deps) -> handler(req, res)`
- `makeService(deps) -> service(input)` :contentReference[oaicite:6]{index=6}

### 4) Drive integration design with tests (selectively)

Use:

- a coarse-grained “walking skeleton” acceptance test for system boundaries
- cheaper unit tests for edge cases and domain rules :contentReference[oaicite:7]{index=7}

---

## Procedure

### Step A — Identify boundaries and contracts

1. List layers (typical):
   - Transport/controller (HTTP handlers, resolvers)
   - Domain (business rules)
   - Repository (DB, external services)
2. For each caller → callee relationship:
   - define the **minimum contract** as a function signature
   - keep it local to the module if possible

**Heuristic:** If a type must be shared, keep it small and stable; otherwise duplicate local types to avoid incidental coupling.

---

### Step B — Refactor one seam at a time

Pick **one** of these seams to start:

#### Option 1: Controller depends on a domain function

- Controller accepts `getTopRatedRestaurants`-like dependency as a parameter
- Unit test stubs that dependency with a simple function

#### Option 2: Domain depends on a repository function

- Domain function accepts repository functions as parameters
- Unit tests stub repository functions without DB scaffolding

#### Option 3: Composition root wires it all together

- Create a small “root” module that:
  - constructs infrastructure dependencies once
  - partially applies them into handlers/services

---

### Step C — Make tests easy and non-transport-aware

Checklist:

- [ ] Domain tests do not import HTTP framework types
- [ ] Domain tests do not require server startup
- [ ] Stubs are plain functions returning deterministic values
- [ ] Adding an unrelated field does not break unrelated tests :contentReference[oaicite:8]{index=8}

---

## Suggested folder pattern (edit freely)

> Replace names to match your project.

- `src/<feature>/controller/`
  - `handler.ts` exports `makeHandler(deps)`
- `src/<feature>/domain/`
  - `service.ts` exports `makeService(deps)` or pure functions
- `src/<feature>/repo/`
  - `repository.ts` exports `makeRepository(db)` or functions
- `src/<feature>/compose/`
  - `index.ts` wires real dependencies

---

## Minimal example template (pseudocode)

### Contracts

- `type GetTopRated = (city) => Promise<RatedRestaurant[]>`

### Controller

- `makeTopRatedHandler({ getTopRated }: { getTopRated: GetTopRated }) => handler(req,res)`

### Domain

- `makeGetTopRated({ loadRatings, isTrustedUser }: Deps) => getTopRated(city)`

### Repository

- `makeLoadRatings(db) => loadRatings(city)`

### Compose

- `const loadRatings = makeLoadRatings(db)`
- `const getTopRated = makeGetTopRated({ loadRatings, isTrustedUser })`
- `export const handler = makeTopRatedHandler({ getTopRated })`

(Use your language’s idioms, but keep the same dependency flow.)

---

## Verification criteria

I’m “done” when:

- dependencies are injected via function parameters (or equivalent)
- business logic can run in unit tests with minimal stubs
- wiring is centralized (composition root) and easy to read
- module boundaries don’t leak many types across directories
- changes in one module don’t break unrelated modules/tests :contentReference[oaicite:9]{index=9}

---

## Knobs you can tune (project-specific)

Edit these to match your preferences:

- **How much type duplication is acceptable?** (low / medium / high)
- **How strict are boundaries?** (directory-level / package-level / workspace-level)
- **Testing style:** (TDD everywhere / TDD only for integration seams / mixed)
- **Composition style:** (factory functions / curried functions / dependency objects)

---

## Quick start prompt (copy/paste)

“Apply the dependency-composition skill to refactor the `<module>` layer.
My current pain is `<pain>`. Language is `<lang>`.
Here are files: `<file1>`, `<file2>`.
Propose (1) target contracts, (2) new composition root wiring, and (3) a minimal test plan.”
