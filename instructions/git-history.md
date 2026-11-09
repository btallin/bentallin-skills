## Git history

Keep history as linear as practical. This is a strong preference, not a ban.

- **Default to rebase:** update a branch from the default branch with `git rebase <default-branch>`, not `git merge <default-branch>`.
- **Land branches fast-forward:** rebase the branch onto the default branch, then `git merge --ff-only <branch>`. For PRs, prefer "Rebase and merge" (or squash) over a merge commit.
- **Merge commits are allowed** when they are the better tool: for example a long-lived branch with many collaborators, a rebase that would need heavy conflict rework, or when the user asks for one. Say why in the commit message or report.
- **Squash long-lived branches when merging:** a branch with many work-in-progress, fixup or back-and-forth commits lands as a single squash commit (`git merge --squash <branch>` or "Squash and merge") with a message summarizing the whole change. If the branch has a few commits that are each meaningful, rebase and fast-forward them instead. Squash only branches that have not been pushed to or used by others, or that are being merged via a PR; never squash history already on the default branch.
- **Never rewrite shared history:** only rebase commits that have not been pushed, or branches only you use. Do not force-push the default branch. If a rebase of a pushed branch is needed, use `--force-with-lease` and tell the user first.
