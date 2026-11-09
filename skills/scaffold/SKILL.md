---
name: scaffold
description: "Scaffold a piece of work as public signatures with docstrings written into the existing code, so the design can be reviewed before any implementation. Stops for approval, then hands off to implement or implement-spec."
disable-model-invocation: true
---

Scaffold the work so the user can review the design before it is built. A scaffold is the public shape of the solution: the new or changed modules, their public signatures and docstrings, and the wiring into existing entry points. It contains no logic. Reviewing a scaffold takes minutes; rejecting a full implementation wastes time and tokens.

Use this for substantial work: new modules, new interfaces, or multi-ticket features. Skip it for small fixes and single-function changes.

An approved scaffold is the base for the build step. `implement` fills the bodies test-first with `tdd`, writing the tests after the scaffold. `implement-spec` turns the scaffold's slices into tickets that point at its signatures.

## 1. Frame the work

- If the user gave a ticket, read it and state its number, title and acceptance criteria before going further. If they gave a spec, read that. If the target is ambiguous, ask.
- Read the repo's agent instructions (`AGENTS.md` or `CLAUDE.md`) and any docs they route you to for this area. Follow the repo's coding and docstring conventions.
- Write down the goal, the acceptance criteria, the non-goals, and every assumption you are making.

## 2. Explore just enough

Find the modules the change touches and their existing interfaces. For a broad sweep, use an Explore subagent at "medium" breadth and ask for conclusions only. Stop reading once the design can be stated.

## 3. Shape the design

Decide:

- which modules are new or changed, and what each one owns;
- public signatures (name, parameters, return type, errors raised) for each new or changed public function or class;
- the data shapes that cross a boundary;
- the flow from entry point to result, in five bullets or fewer;
- the open choices, each with your recommended option.

Prefer deep modules with small interfaces. If the `codebase-design` skill is available, use its vocabulary. Do not settle a choice the request left open without marking it as a question for review.

## 4. Write the scaffold

Work on a local branch `scaffold/<slug>` in its own worktree, based on the current base branch. Write into the existing application, not a separate sketch directory.

- **Signatures and docstrings.** Write the public signatures and docstrings in the real modules, following the repo's docstring convention. Each function or method body is `raise NotImplementedError("scaffold: <slug>")`. Include no logic.
- **Wiring.** Connect new code to existing entry points (CLI command, route, registry) as stubs where the design needs it.
- **No tests.** Do not write test files at this stage. Tests come after the scaffold is approved.
- **Verify.** Run import, lint and type checks on the changed files only. Use the commands from `AGENTS.md`; if they run in Docker, use the Docker commands. Fix any failure before stopping.
- **Commit** on the scaffold branch as `chore(scaffold): scaffold <slug>`. The commit body records the approval state and the open questions, so the record survives without any extra file.

Open a draft PR only if the user asks for one. Its title is the same conventional-commit subject, and its body carries the design summary and open questions. Do not use closing keywords.

## 5. Stop for review

Reply with:

- the goal and the module map;
- the key signatures and the flow, briefly;
- the open questions, each with its recommendation;
- the branch name, and the PR link if one was opened.

Then end the turn and ask for feedback or approval. Do not fill any body. Stopping here is the purpose of this skill.

Continue past this step only if the user asked up front for scaffold-and-build in one go.

## 6. Revise on feedback

Change the signatures and docstrings in place. Re-run verification, commit the change, and say in plain terms what changed and why. Repeat until the user approves.

When the user approves, amend the scaffold commit's body to record the approval, the date, and the decisions made during review.

## 7. Hand off on approval

Scaffold fits at any point before building. With mattpocock-skills it sits between `to-spec` and `to-tickets` (scaffold the spec, get the design approved, then cut tickets that point at the approved signatures) or directly before `implement` for a single ticket. Without those skills, hand the approved scaffold to whatever build step the user names.

- **One ticket or a small change:** call the Skill tool with `implement` on the scaffold branch. It writes the tests with `tdd` after the scaffold, then fills the bodies. Tell it to keep the approved signatures. If it finds a real problem with a signature, it must stop and report, not change the design quietly.
- **Several tickets or a spec:** create one ticket per independently shippable slice. Each ticket names its signatures and modules. Then call the Skill tool with `implement-spec`, using the scaffold branch as its integration branch.

The scaffold commit stays in history as its own commit. Reviewing `scaffold/<slug>..HEAD` then shows only what the implementation added.

## Rules

- A scaffold contains no behavior. Bodies raise `NotImplementedError`, and no tests are written at this stage.
- Scaffold only what the acceptance criteria need. Any extra module must be justified in the reply.
- Do not start `implement` or `implement-spec` without the user's explicit approval. Silence and a reply that only asks questions are not approval.
- If the user rejects the approach, say so and ask before deleting the scaffold branch. Deleting it is the cheap way to drop a design, but it is still their decision.
