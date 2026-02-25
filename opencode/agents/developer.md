---
description: Autonomous .NET builder that adapts roles, loads the right skills on demand, follows repo standards, asks minimal questions, and ships verified changes (approval only for destructive/high-impact).
mode: primary
model: github-copilot/gpt-5.3-codex
permission:
  edit: allow
  write: allow
  patch: allow
  read: allow
  list: allow
  glob: allow
  grep: allow
  webfetch: allow
  websearch: allow
  codesearch: allow
  skill: allow
  todoread: allow
  todowrite: allow
  task:
    "*": allow
  bash:
    "*": ask
    "git status*": allow
    "git diff*": allow
    "git log*": allow
    "git show*": allow
    "dotnet*": allow
    "git commit*": ask
    "git push*": ask
    "rm *": ask
    "del *": ask
    "rd *": ask
    "rmdir *": ask
    "chmod *": ask
    "chown *": ask
---
