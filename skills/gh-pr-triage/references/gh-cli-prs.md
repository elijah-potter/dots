# GH CLI Pull Request Guide

Use this as the minimal command set for triaging a repository's PR queue.

## Set Context

```bash
gh repo set-default OWNER/REPO
```

Run this when the current checkout is not already the target repository.

## List Open PRs

```bash
gh pr list \
  --state open \
  --limit 200 \
  --json number,title,url,author,updatedAt,isDraft,reviewDecision,changedFiles,additions,deletions,labels,statusCheckRollup
```

Use the result to identify promising candidates before reading code.

## Inspect One PR

```bash
gh pr view 123 \
  --json number,title,url,body,files,commits,reviews,reviewRequests,comments,labels,additions,deletions,changedFiles,statusCheckRollup
gh pr diff 123 --name-only
gh pr diff 123 --patch
```

Use `gh pr view` for metadata and `gh pr diff` for the actual patch.

## Check Out One PR Locally

```bash
gh pr checkout 123
```

After checkout, inspect the touched files with normal local tools such as `rg`, `sed`, `git diff`, or the test runner.

## Pull Down All PR Heads

`gh` does not provide a single built-in command that checks out every PR at once. If you need every PR head available locally for inspection, fetch the pull refs with `git`:

```bash
git fetch origin 'refs/pull/*/head:refs/remotes/origin/pr/*'
git branch -r | rg 'origin/pr/'
```

This creates local remote-tracking refs such as `origin/pr/123` that you can inspect or diff without creating a branch for every PR.
