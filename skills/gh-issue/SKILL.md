---
name: gh-issue
description: View and inspect GitHub issues by number using the GitHub CLI. Use when asked to read an issue, fetch issue comments, open an issue in the browser, or inspect an issue from outside the repository with an explicit owner/repo.
---

# Gh Issue

Use `gh issue view` to read issue details in the terminal quickly and consistently.

## Quick Commands

Read an issue in terminal:

```bash
gh issue view <number>
```

Read an issue with all comments:

```bash
gh issue view <number> --comments
```

Open an issue in browser:

```bash
gh issue view <number> --web
```

Read an issue outside the repo directory:

```bash
gh issue view <number> --repo owner/repo
```

Skim only title and body:

```bash
gh issue view <number> --json title,body --jq '.title, .body'
```

## Workflow

1. Confirm the issue number.
2. Run `gh issue view <number>` first.
3. Add `--comments` when full discussion history is needed.
4. Add `--repo owner/repo` when not inside the target repository.
5. Add `--web` when interactive browser reading is preferred.
6. Use `--json ... --jq ...` for machine-friendly or minimal output.

## Notes

- Prefer terminal output by default.
- Preserve exact CLI commands in responses when giving instructions.
- If the command fails, check `gh auth status` and repository access.
