---
description: Write and create a commit for the approved change set (exactly one commit; no edits).
agent: Builder
subtask: true
---

First, load and follow my repo skill:

- Call the `skill` tool to load: writing-commits

Inputs ($ARGUMENTS):

- The user may pass either:
  1. a list of file paths to add, or
  2. a diff/patch to add.
- If no diff and no files are provided, use `git` commands to detect the modified files.

Task:

1. Determine the change set to commit:
   - If $ARGUMENTS contains a diff, apply/stage it (and only it).
   - Else if $ARGUMENTS contains file paths, stage exactly those files.
   - Else, use git to find modified files and stage the intended/approved set.
2. Write a commit message that follows the guidance from `writing-commits`.
3. Create exactly ONE commit.
4. Do not edit code. Do not create additional commits. Do not push.
5. Output: the final commit message and the commit hash.
