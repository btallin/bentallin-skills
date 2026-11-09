#!/usr/bin/env bash
# Opt-in: make the default instructions load in every Claude Code session.
# Adds one @import line to ~/.claude/CLAUDE.md (idempotent). Copilot has no
# import syntax; see README for the one-line copy command.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="$HOME/.claude/CLAUDE.md"
line="@$here/instructions/default.md"
mkdir -p "$(dirname "$target")"
touch "$target"
if grep -qxF "$line" "$target"; then
  echo "Already installed in $target"
else
  printf '\n%s\n' "$line" >> "$target"
  echo "Added to $target: $line"
fi
