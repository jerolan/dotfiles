---
name: defensive-development
description: Apply NASA/JPL-style defensive programming practices: constrain complexity, validate boundaries, enforce deterministic behavior, and require verification evidence.
---

## What I do

I help you implement "NASA-like" defensive development in this codebase by:

- Defining a **defensive subset** (critical modules) with stricter rules
- Constraining code patterns to make behavior **predictable and verifiable**
- Enforcing **boundary validation** and consistent error handling
- Producing **copy-pasteable artifacts**: checklists, PR templates, CI gates, and code patterns

## When to use me

Use me when:

- You’re introducing new features in safety-/reliability-critical areas
- You’re refactoring unstable modules
- You want to harden inputs, error paths, timeouts, and failure isolation
- You want actionable rules that are easy to review and automate

Do not use me for exploratory spikes where speed matters more than rigor.

## What I need (inputs)

Provide (or let me infer) the following:

- Languages and frameworks used (e.g., TypeScript, Java, C/C++, Rust)
- Test runner + CI system (GitHub Actions, GitLab CI, etc.)
- Where failures hurt most (e.g., payments, auth, ETL pipelines, device control)
- Existing linters/formatters/static analyzers (if any)

If you don’t provide these, I will generate a conservative baseline and mark assumptions.

## Outputs you should expect

Depending on your request, I will produce one or more:

1. **Defensive Development Policy** (short rules, enforceable)
2. **Critical-Module Boundary Map** (what is “critical” vs “non-critical”)
3. **PR Checklist** and/or **CODEOWNERS-style review gates**
4. **CI Gates** (warnings-as-errors, lint, static analysis, tests, coverage targets for risky code)
5. **Reference patterns** (validation, error handling, retry/timeouts, safe defaults)

## Core principles (NASA/JPL-style, adapted)

### A) Constrain complexity

- Prefer simple control flow; avoid cleverness in critical paths
- Make loops bounded or provably terminating
- Minimize global state; keep scopes tight
- Prefer explicit, typed interfaces over implicit conventions

### B) Validate at boundaries

- Validate _all external inputs_ at module boundaries (API, files, queues, env, user input)
- Use whitelists over blacklists (allowed shapes/ranges)
- Normalize early, reject fast, and log diagnostically (without secrets)

### C) Determinism and safe failure

- Use timeouts for I/O and remote calls
- Make failure modes explicit (safe defaults, degraded mode, circuit breaker where relevant)
- Ensure idempotency where retries are used

### D) Evidence-based verification

- Require tests for normal + boundary + error paths
- Track and test invariants (assertions / contracts where appropriate)
- Prefer automation: linters + static analysis + build gates in CI

## Process (how to apply this skill)

### Step 1 — Identify critical modules

I will propose a “critical subset” such as:

- Authn/authz, payments, data integrity pipelines, device control, security boundaries, migration logic
  Output: a short list of folders/files and why they’re critical.

### Step 2 — Define enforceable rules

I will produce a compact set of rules, for example:

- Mandatory input validation at boundary functions
- No silent catches; every failure is handled or propagated consistently
- Timeouts required for network/DB calls
- “No new complexity” guardrails (e.g., cyclomatic complexity threshold, file size limit, banned patterns)

### Step 3 — Implement automation gates

I will propose CI gates aligned with the stack:

- Warnings-as-errors (where applicable)
- Lint + formatting
- Static analysis (language-appropriate)
- Unit tests + targeted integration tests
- Coverage expectations focused on **risky modules** (not vanity %)

### Step 4 — Add review ergonomics

I will create:

- PR checklist section
- “risk label” policy (e.g., `risk:high` requires extra review/tests)
- A lightweight template reviewers can follow consistently

## Verification checklist (definition of done)

A change is “defensive-complete” when:

- [ ] Inputs validated at boundaries (range/shape/nullability)
- [ ] Error paths handled (no silent failure; consistent propagation)
- [ ] Timeouts/retries are explicit (and capped)
- [ ] Logs/metrics support diagnosis without leaking secrets
- [ ] Tests include boundary + failure cases
- [ ] CI gates pass and provide evidence (lint/analyze/test)

## Limits

- I cannot guarantee correctness without running tests and reviewing actual code behavior.
- If the repo lacks tests/CI, I will still produce policies and file changes, but verification will be weaker.
- Some strict rules may be too heavy for non-critical modules; I will default to a “critical subset” approach.

## Example prompts (copy/paste)

- "Apply defensive-development to the auth module in @src/auth. Produce rules + CI gates + a PR checklist."
- "Create a critical subset map for this repo, then add a lightweight defensive policy for those folders."
- "Harden input validation and error handling for @src/api/routes/user.ts using the defensive-development rules."

````

---

## 3) (Optional) Allow the skill via permissions

In `opencode.jsonc`, you can explicitly allow this skill (pattern-based). ([OpenCode][1])

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "skill": {
      "defensive-development": "allow",
      "*": "ask"
    }
  }
}
````
