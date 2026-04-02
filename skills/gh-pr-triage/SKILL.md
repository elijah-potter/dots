---
name: gh-pr-triage
description: Prioritize open GitHub pull requests using gh CLI and direct code inspection. Use when Codex needs to scan a repository's PR backlog, identify three low-effort "slam dunk" reviews, identify one larger high-value PR worth sustained attention, include direct GitHub links, and explain what to look at in the code before handing the list to a human reviewer.
---

# GitHub PR Triage

## Overview

Scan a repository's open PRs, shortlist the ones that deserve attention, and do the first pass of review prep before reporting back. Use GitHub metadata to narrow the field, then read the actual code and tests for each shortlisted PR so the final recommendation is specific and immediately actionable.

Read [references/gh-cli-prs.md](references/gh-cli-prs.md) for a brief gh CLI guide for listing PRs, fetching details, checking out candidates, and bulk-fetching PR refs.

## Workflow

1. Establish repository context.
- Confirm the target repository and remote before collecting PRs.
- Use `gh repo set-default OWNER/REPO` when the current directory is not already enough context.

2. Gather the open PR set.
- Start with `gh pr list --state open --limit 200 --json ...` to collect URL, title, author, update time, diff size, labels, draft status, review state, and checks.
- If the repository has a large queue, sort or filter by freshness and reviewability before deeper inspection. Ignore stale drafts unless the user explicitly wants them.

3. Build an initial shortlist from metadata.
- Favor candidates with small to moderate churn, narrow scope, clear titles, clear PR descriptions, and visible tests or checks.
- Penalize huge diffs, vague descriptions, stacked PRs that depend on unmerged work, broken checks, or work that obviously requires domain-specific coordination.
- Do not stop here. Metadata is only the filter, not the conclusion.

4. Read the actual code for the shortlisted PRs.
- For every final recommendation, inspect the PR body, changed file list, and diff.
- Open the touched files locally after `gh pr checkout <number>` or inspect with `gh pr diff <number> --patch`.
- Skim or read relevant tests, fixtures, migrations, API contract changes, and user-facing copy.
- Look for risk concentration: auth, migrations, concurrency, state transitions, caches, feature flags, error handling, config surface, and backwards compatibility.
- Prefer concrete file-level observations over generic statements.

5. Select exactly four PRs unless the repo genuinely does not have enough viable candidates.
- Pick three "slam dunks": PRs that should be fast to review and likely need minimal back-and-forth.
- Pick one "big" PR: a larger or more involved change that still looks worth focused review time.
- If there are fewer than three credible slam dunks, say so plainly and return the best available set rather than forcing weak picks.

## Selection Rubric

### Slam Dunks

- Choose focused PRs with low review overhead.
- Favor small or medium diffs, isolated modules, strong tests, straightforward intent, and low coordination risk.
- Prefer changes where a reviewer can answer "Is this correct?" quickly after reading the diff.
- Good examples: typo-level docs plus a tiny code fix, one-file bug fix with tests, scoped refactor with no behavior change, small integration tweak with obvious validation.

### Big PR

- Choose one PR that is materially important even if it needs sustained attention.
- Favor strategic impact, architectural importance, or changes touching a hot path that deserve a careful human review.
- The ideal big PR is not merely large; it is important enough that deeper engagement pays off.
- Avoid recommending a chaotic or obviously unreviewable PR unless there is no better candidate and you explain the tradeoff.

## Required Output

Return two sections in this order.

### Slam Dunks

Provide exactly three items when possible. For each item include:
- PR title and number
- Direct GitHub link
- One short paragraph on why it is a slam dunk
- A short "Pay attention to" list with concrete code-review checkpoints grounded in the changed files
- A rough effort estimate such as "5-10 minutes" or "15-20 minutes"

### Big PR

Provide exactly one item. Include:
- PR title and number
- Direct GitHub link
- Why it is worth the time
- A short "Pay attention to" list with concrete code-review checkpoints grounded in the changed files
- The main risk areas or questions a reviewer should resolve first
- A rough effort estimate

## Quality Bar

- Always include links. Never return bare PR numbers without URLs.
- Do not recommend PRs based only on titles, labels, or diff stats.
- Read code before making the final call. If you did not inspect the diff, the work is incomplete.
- Give file-aware tips, not generic advice like "check tests" unless you name the relevant tests or explain the specific behavior under test.
- Surface uncertainty when repository context is missing, but still do the best triage possible with available artifacts.
- Optimize for reducing follow-up work. The final output should help the human reviewer decide where to spend time without another round of discovery.

## Notes

- Prefer local file inspection once a PR is shortlisted; it is faster and more reliable than repeatedly re-requesting large diffs from GitHub.
- Mention when a candidate is easy mostly because it is self-contained versus easy because the code is already familiar and well-tested.
- If the repository has no good big PR, say that explicitly instead of inventing one.
