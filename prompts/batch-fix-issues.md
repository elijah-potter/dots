---
description: Identify linter issues with easy wins and produce fixes for them.
---

Using `gh`, search through 100 randomly selected issues from this repository.
From those, select 5 based on the following criteria.

- There are not already PRs closing them.
- The issues have clear example text that we can use to create unit tests.
- They are not duplicates of each other.
- They must all be rules related to a specific linting rule.
    - False positives
    - False negatives

Once you have selected the issues, replicate each one locally to prove that it still exists.
Then, fix the problems by either writing a new rule (in the case of false-negatives), or by modifying an existing rule (in the case of false-positives). When dealing with false-negatives, make sure a modification to an existing rule might not produce a simpler diff before writing a new rule.
Prefer writing Weir rules over Rust rules for simplicity and seek to maximize generality when writing new rules.
Either way, make sure you read ALL relevant documentation before you start writing code.

Any changes to a rule must be accompanied by 10 additional unit tests for that rule to ensure you haven't introduced any new false positives or false negatives while also fixing the underlying issue.

Simplify the code as much as possible. These rules should be easy to read and review.

Do not make any commits, push anything, or create or modify any PRs.
Changes should stay local and unstaged.

Write the pull request description without opening a pull request by creating `PR.md` in the repository root.
Follow `.github/pull_request_template.md`. In `# Issues`, list the selected issue numbers and use `Fixes #...` only for issues actually addressed by the branch.

Make sure to run `just check-rust test-rust` after making your changes to make sure they constitute valid code and do not cause tests to fail.
