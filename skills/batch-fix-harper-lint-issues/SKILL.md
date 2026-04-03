---
name: batch-fix-harper-lint-issues
description: Batch-fix recent Harper linting issues from GitHub. Use when Codex needs to inspect the 100 most recent Harper issues, choose five actionable false-positive or false-negative reports, reproduce them locally, implement new linters or patch existing ones, run `just check-rust test-rust`, fuzz the touched rules with `$harper-rule-fuzzing`, and write `PR.md` from the repository template without committing or opening a pull request.
---

# Batch Fix Harper Lint Issues

## Overview

Work through a small batch of recent Harper linting bugs end to end: collect recent issue reports, choose a focused set of five false positives or false negatives, land code and test changes, harden the affected rules, and leave the branch ready for a human review.

## Hard Constraints

- Do not commit.
- Do not open a pull request.
- Do not push a branch.
- Do not count an issue as fixed unless it is reproduced locally or is clearly covered by a nearby failing test or snapshot.
- Do not force five fixes by picking duplicates. Prefer five distinct root causes.
- Do not make unrelated cleanup edits just to quiet the tree.

## Workflow

1. Establish repository context.
- Confirm the current repository is the Harper repo.
- Use `gh repo set-default OWNER/REPO` if the current directory is not enough context for `gh`.

2. Check for existing pull requests that already address the issues.
- Search open and recently closed pull requests for the same rules, issue numbers, or reproduction text before doing any issue triage.
- If an existing PR already covers the same problem, prefer that context and avoid duplicating the work unless the user explicitly wants a separate fix.
- Note any overlapping PRs in `PR.md` if they materially affect the batch or the review story.

3. Gather the candidate issue set.
- Fetch the most recent 100 issues with `gh issue list --state all --limit 100 --search "sort:created-desc" --json number,title,url,labels,createdAt,updatedAt,state,body`.
- Prefer open issues for the five-item batch.
- Use recently closed issues as regression context only unless the user explicitly wants them included.

4. Shortlist false positives and false negatives.
- Treat labels like `false-positive`, `bug`, `harper-core`, and `linting` as hints, not proof.
- Treat issue-template language like "What got flagged?" as a false-positive signal.
- Treat language like "Harper missed", "should flag", or "did not catch" as a false-negative signal.
- Read the strongest candidates in full with `gh issue view <number> --comments`.

5. Choose exactly five actionable issues when possible.
- Prefer issues with clear reproduction text.
- Skip duplicates and near-duplicates unless they expose different root causes.
- Spread the batch across different rules or subsystems when possible.
- If the most recent 100 issues do not contain five confident candidates, say so plainly in `PR.md` and explain what blocked the missing slots.

6. Reproduce each issue before editing.
- Extract the smallest example that demonstrates the problem from the issue body or comments.
- Confirm current behavior with `cargo run --bin harper-cli --release -- lint "<TEXT>"` or a targeted test.
- Check whether the behavior is already covered by an existing linter before adding new logic.
- For compound-word issues, inspect the existing closed-compound handling before writing a new rule.

7. Implement the fixes.
- Prefer patching an existing linter when the issue naturally belongs there.
- Add a new linter or Weir rule only when no existing rule is the right home.
- Keep each issue tied to at least one regression test.
- When writing a new rule, include at least 15 tests spanning true positives, false positives, false negatives, and nearby edge cases.
- Sanity-check new rule ideas with `cargo run --bin harper-cli --release -- lint <TEXT>` before assuming the gap is real.
- If a Weir rule is the right fit, consult `packages/web/src/routes/docs/weir/+page.md` and `packages/web/src/routes/docs/contributors/author-a-rule/+page.md`.

8. Validate continuously.
- Run targeted Rust tests for touched modules while developing.
- Run `just check-rust test-rust`.
- Fix all resulting problems, including snapshot failures.
- Regenerate snapshots only when the semantic change is understood and intentional, then inspect the snapshot diff.

9. Fuzz each touched rule for additional false positives.
- Use `$harper-rule-fuzzing` when available.
- Fuzz one rule at a time. Do not fuzz the full rule set.
- Treat corpus hits as leads that require review, not automatic bugs.
- Add or adjust regression tests for any real false positives the fuzz pass reveals.
- Re-run `just check-rust test-rust` after fuzz-driven fixes.

10. Simplify the code as much as possible. These rules should be easy to read and review.
- Try rewriting the rules in Weir. Do they get simpler?
- Prefer placing code in the expression rather than in the match_to_context when writing ExprLinters.

11. Write the pull request description without opening a pull request.
- Create `PR.md` in the repository root.
- Follow `.github/pull_request_template.md` in the same section order:
  - `# Issues`
  - `# Description`
  - `# Demo`
  - `# How Has This Been Tested?`
  - `# Checklist`
- In `# Issues`, list the selected issue numbers and use `Fixes #...` only for issues actually addressed by the branch.
- In `# Description`, summarize the rule or linter changes grouped by issue.
- In `# Demo`, write `N/A` unless screenshots or output excerpts genuinely help.
- In `# How Has This Been Tested?`, include targeted tests, `just check-rust test-rust`, and the per-rule fuzz passes.
- In `# Checklist`, mark only truthful items.

## Notes

- Prefer surgical fixes over broad heuristics.
- Keep issue text, test cases, and final explanations aligned so a reviewer can trace each code change back to a report.
- Leave the tree ready for human review, then stop before any commit or PR action.
