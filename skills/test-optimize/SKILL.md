---
name: test-optimize
description: Profile the test suite once, save the timing report to disk, and propose the 5 best fixes or removals to make it faster. Asks before changing anything. Use when the test suite is slow, exceeds its time budget, or the user asks to speed up or trim tests.
disable-model-invocation: true
---

Find out why the suite is slow, record it, and propose changes. Never change tests without the user's approval.

## 1. Reuse or create the profile

Profiles live in `.scratch/test-speed/profiles/` (create it if missing; make sure `.scratch/` is gitignored).

- If a profile exists and the user did not ask for a fresh run, read the newest one and skip to step 3. Say which file and its date.
- Otherwise run the suite **once** with per-test timings and save the raw output to `.scratch/test-speed/profiles/<YYYY-MM-DD-HHMM>.txt`. Find the runner from the repo's instructions or config. Examples: `uv run pytest --durations=0 -p no:cacheprovider`, `npx vitest run --reporter=verbose`, `npx jest --verbose`, `go test -json ./...`, `cargo test -- --report-time`. Add `-n 0` or the equivalent serial flag when practical, because contention inflates parallel timings.
- Never rerun the suite just to look at the data again. Work from the saved file.

## 2. Write the summary report

Next to the raw file, write `<same-name>.md` containing: total wall time, test count, the 20 slowest tests with times, the slowest files/modules, and the commands used. Share only the headline numbers in chat.

## 3. Propose exactly 5 changes

Rank by seconds saved per unit of risk. Each proposal has: the test(s) or file, current time, the cause (real I/O, sleeps, heavy fixture setup, repeated setup that could be shared, over-broad integration test, redundant coverage, tests for removed behavior), the proposed fix, the estimated saving, and the risk to coverage.

Fix types, in rough order of preference:
1. Delete tests for functionality that no longer exists, and duplicates of other tests' coverage.
2. Replace sleeps and real waits with fake clocks or events.
3. Share expensive setup (session/module-scoped fixtures, in-memory DB, cached build).
4. Mock slow external boundaries (network, subprocess), at seams only.
5. Shrink data sizes and parameter grids.
6. Mark as slow and exclude from the default run, only as a last resort and only with user agreement.

Use the repo's time budget if it defines one (check `CLAUDE.md`/`AGENTS.md`). Otherwise assume: suite under 1 minute, unit tests under 1 second each, nothing over 5 seconds without a user exception.

## 4. Ask before implementing

Present the 5 proposals as a numbered list with estimated savings and total, then ask the user which to apply (all, some, none). Do not edit any test until they answer. After approval, implement only the chosen ones, run only the affected tests plus a before/after timing of those, and save an updated report. Do not run the full suite more than once at the end, and only if the user wants a final number.
