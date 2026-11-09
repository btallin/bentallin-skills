## Git history

Keep history as linear as practical. This is a strong preference, not a ban.

- **Default to rebase:** update a branch from the default branch with `git rebase <default-branch>`, not `git merge <default-branch>`.
- **Land branches fast-forward:** rebase the branch onto the default branch, then `git merge --ff-only <branch>`. For PRs, prefer "Rebase and merge" (or squash) over a merge commit.
- **Merge commits are allowed** when they are the better tool: for example a long-lived branch with many collaborators, a rebase that would need heavy conflict rework, or when the user asks for one. Say why in the commit message or report.
- **Never rewrite shared history:** only rebase commits that have not been pushed, or branches only you use. Do not force-push the default branch. If a rebase of a pushed branch is needed, use `--force-with-lease` and tell the user first.
