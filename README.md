# btallin-ai-skills

Personal skills library, usable from both Claude Code and GitHub Copilot.

Every skill is a folder in `skills/` containing a `SKILL.md` (the open Agent Skills format: YAML frontmatter with `name` and `description`, then instructions). Both tools read this same format, so there is one source of truth.

## Layout

```
skills/<skill-name>/SKILL.md   # one folder per skill (+ optional scripts/reference files)
.claude-plugin/                # Claude Code plugin + marketplace manifests
```

## Install

### Claude Code (plugin)

```
/plugin marketplace add <github-user>/btallin-ai-skills
/plugin install btallin-ai-skills@btallin-ai-skills
```

Local dev: `/plugin marketplace add /home/bentallin/code/btallin-ai-skills`

### GitHub Copilot

Copilot reads skills from `.github/skills/` (per repo) or `~/.copilot/skills/` (personal). Simplest is a symlink:

```
ln -s "$PWD/skills" ~/.copilot/skills
```

(or link individual skill folders if you already have other skills there).

## Adding a skill

1. `mkdir skills/<kebab-case-name>` and create `SKILL.md`.
2. Frontmatter `name` must match the folder name; `description` should say what it does **and when to use it**.
3. Keep the body short; put long reference material in sibling files and link to them.
4. Stick to frontmatter fields both tools understand (`name`, `description`) to stay compatible.
