# bentallin-skills

Personal skills library, usable from both Claude Code and GitHub Copilot.

Every skill is a folder in `skills/` containing a `SKILL.md` (the open Agent Skills format: YAML frontmatter with `name` and `description`, then instructions). Both tools read this same format, so there is one source of truth.

## Skills

| Skill | Purpose |
|---|---|
| `eod` | End of day: writes a handoff doc, a paste-ready prompt for the next AI session, and a short note for you. Uses `mattpocock-skills:handoff` when available. |
| `scaffold` | Writes public signatures + docstrings into the real code (bodies raise `NotImplementedError`) so you can review the design before implementation. Pairs with mattpocock `to-spec`, `to-tickets`, `implement`, `implement-spec`. |
| `test-optimize` | Times the suite once, saves the report to `.scratch/test-speed/profiles/`, proposes 5 fixes/removals, asks before changing anything. |

## Default instructions

`instructions/` holds always-on guidance (not skills): `git-history.md` (linear history, rebase by default) and `testing-speed.md` (run only relevant tests, time budgets, delete tests with removed code; extends `mattpocock-skills:tdd`). Project `CLAUDE.md` files override them.

- Claude Code: `./install-instructions.sh` adds an `@import` to `~/.claude/CLAUDE.md`.
- Copilot (no imports): `cat instructions/git-history.md instructions/testing-speed.md >> ~/.copilot/copilot-instructions.md`, or paste into a repo's `.github/copilot-instructions.md`.

## Layout

```
skills/<skill-name>/SKILL.md   # one folder per skill (+ optional scripts/reference files)
instructions/                  # always-on guidance snippets
.claude-plugin/                # Claude Code plugin + marketplace manifests
```

## Install

### Claude Code (plugin)

```
/plugin marketplace add <github-user>/bentallin-skills
/plugin install bentallin-skills@bentallin-skills
```

Local dev: `/plugin marketplace add /home/bentallin/code/bentallin-skills`

### GitHub Copilot CLI (plugin)

Copilot CLI reads the same `.claude-plugin/` manifests, so the same plugin installs there:

```
copilot plugin marketplace add btallin/bentallin-skills
copilot plugin install bentallin-skills@bentallin-skills
```

(Inside a session: `/plugin marketplace add ...` and `/plugin install ...`.)

### GitHub Copilot in VS Code / other (no plugin)

Copilot reads skills from `.github/skills/` (per repo) or `~/.copilot/skills/` (personal). Symlink:

```
ln -s "$PWD/skills" ~/.copilot/skills
```

## Adding a skill

1. `mkdir skills/<kebab-case-name>` and create `SKILL.md`.
2. Frontmatter `name` must match the folder name; `description` should say what it does **and when to use it**.
3. Keep the body short; put long reference material in sibling files and link to them.
4. Stick to frontmatter fields both tools understand (`name`, `description`) to stay compatible.
