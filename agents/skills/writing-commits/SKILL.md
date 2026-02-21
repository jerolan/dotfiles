---
name: writing-commits
description: Use this when you need to write or review a Git commit message (before committing or opening a PR): imperative subject, blank line, and a problem/why-focused body with evidence and impact.
---

## What I do

- Produce review-friendly commit messages that explain **problem → why → approach**.
- Enforce the Linux-kernel style: short imperative subject, blank line, wrapped body.

## When to use me

Use this skill when preparing commit messages for code changes (features, fixes, refactors),
especially when reviewers need the **reasoning** captured in history.

## Format (mandatory)

### 1) Subject

- Imperative, present tense: `Fix`, `Add`, `Remove`, `Handle`, `Refactor`
- Keep short and concrete (prefer **≤ 50 chars**, no trailing period)
- Optional subsystem prefix: `subsystem: summary`

### 2) Blank line

### 3) Body

- Wrap at ~72 columns
- Focus on:
  - **Problem** (what was broken/missing)
  - **Why it matters** (impact: correctness, users, ops, security)
  - **Why this approach** (trade-offs, constraints, alternatives rejected)
- Add evidence when relevant:
  - repro steps
  - short log/error excerpts
  - invariant reasoning
  - perf numbers (before/after)

## Style rules

- Technical, direct, factual.
- No fluff (“improved”, “updated”) without specifics.
- Prefer causality (“because”) over listing changes (“and”).
- Don’t narrate the diff; describe behavior + rationale.
- Don’t mention tools/process unless it clarifies the change.
- No blame language.

## Optional trailers / references

Add only when applicable (each on its own line):

- `Fixes: <sha>`
- `Closes: <issue>`
- `Reported-by: <name>`
- `Co-authored-by: <name>`

## Conventional Commits (only if required by repo)

If the repo mandates Conventional Commits:

- Keep the required prefix in the subject (e.g., `fix(api): ...`)
- Still follow the same body rules (blank line + why-focused, wrapped).

## Templates

subsystem: concise imperative summary

Describe the problem and user/operational impact.
Explain why this approach is correct and what was rejected.

Evidence if relevant (repro/logs/numbers).
Optional trailers (Fixes/Closes/Reported-by/...).

### Example (illustrative)

parser: reject empty tokens in split()

The tokenizer accepted empty tokens when the delimiter appeared at the
start of the input. That violates the parser contract and triggers a
downstream out-of-bounds access in decode().

Treat leading delimiters as separators and skip empty fields. This keeps
the token stream consistent and matches how the rest of the parser
handles repeated delimiters.

Fixes: 1a2b3c4d
