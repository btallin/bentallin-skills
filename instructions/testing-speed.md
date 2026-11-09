## Development checks and testing speed

These rules apply on top of any TDD workflow, including `mattpocock-skills:tdd`. A repo's own `CLAUDE.md`/`AGENTS.md` overrides the numbers below.

- **Run only relevant tests while developing.** Run the tests for the file, module or function you are changing (for example `pytest tests/x/test_y.py -k name`), not the whole suite, on each red/green iteration.
- **Run the full checks once, at the end.** Lint, types and the full test suite run when you finish a task or a set of tasks, not on every change.
- **Be selective when adding tests.** Every test must earn its runtime. Test at agreed seams, not every edge case.
- **Time budget (starting point; each project may differ):** whole suite under 1 minute. An individual unit test ideally under 1 second; if it is slower, look for optimizations. Anything over 5 seconds is not accepted without an explicit user exception.
- **Delete tests when you remove functionality**, so the suite does not accumulate irrelevant tests.
- **If the suite exceeds its budget**, stop adding tests and use the `test-optimize` skill to profile and trim it.
- Do not weaken the checks (loosen config, skip, blanket-ignore) to get green.
