---
name: eod
description: End-of-day wrap-up. Writes a handoff document, a ready-to-paste prompt for the next AI session, and a short note for the human, so work can stop now and resume later. Use when the user says "eod", "end of day", "wrapping up", or wants to stop and pick the task up later.
disable-model-invocation: true
---

Capture the current work so it can be resumed cold, by a fresh AI session or by the user after a night away. Produce three artifacts in one folder.

## 1. Pick the folder

Use `<repo-root>/.scratch/eod/<YYYY-MM-DD>-<slug>/`, where `<slug>` is a few kebab-case words naming the task. Create it. If `.scratch/` is not gitignored, add it to `.gitignore` and tell the user. Outside a git repo, use `~/.eod/<slug>/<YYYY-MM-DD>/` instead.

## 2. Gather state (do not guess)

Run what you need to be accurate: `git status`, `git branch --show-current`, `git log --oneline -10`, `git diff --stat`, and any open PR for the branch. Note what is committed, what is uncommitted, and what is unpushed. If the work is uncommitted and the user has not said otherwise, do not commit for them; record it. Do not run the full test suite just to report on it; report the last known result and say when it was run.

## 3. Write `handoff.md`

For the next agent. If the `mattpocock-skills:handoff` skill is available, call it to produce this document, then move the result into the folder from step 1. Otherwise write it from scratch with these sections:

- **Goal**: what the task is and why, in two or three sentences.
- **Current state**: done, in progress, and not started. Branch, uncommitted changes, last test/check result.
- **Decisions made**: choices and the reason for each, including options rejected.
- **Open questions and blockers**: anything awaiting the user or an external thing.
- **Next steps**: ordered, concrete, each small enough to start without further research.
- **Key files and references**: paths with a line of context each. Link specs, tickets, ADRs, PRs and commits instead of restating them.
- **Gotchas**: traps, flaky tests, commands that need special flags, things already tried that failed.
- **Suggested skills**: skills the next agent should invoke.

Redact secrets, tokens and personal data.

## 4. Write `next-prompt.md`

A single self-contained prompt the user can paste into a new session. It must work without this conversation. Include: one sentence of context, the instruction to read `handoff.md` at its absolute path first, the exact first action to take, the constraints to respect (branch, do not touch X, ask before Y), and what "done" looks like. Keep it under about 200 words. No placeholders left unfilled.

## 5. Write `note.md`

For the human, readable in under a minute. Three short parts, plain language, no jargon the user did not use:

- **Working on**: one or two sentences.
- **Where I left it**: the state, including anything uncommitted or half-broken.
- **Start here tomorrow**: the single next action, then the one after.

## 6. Report

Print the folder path and the contents of `note.md`. Mention the file paths of the other two. Do not print the full handoff.

## Rules

- Accuracy over completeness: if you do not know a state, say "unknown" rather than inventing it.
- Do not duplicate content that lives in specs, tickets, commits or diffs; link to it.
- Do not push, commit, or change code as part of this skill unless the user asks.
