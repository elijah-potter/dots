--- 
description: Review A PR
argument-hint: "<PR NUMBER>"
---

Please review PR #$@ by diffing it against `master`.
If I neglected to provide a PR number above, ask for it.

If it contains changes to rules, test it and try to find an example of a false-positive.
Otherwise, look for correctness and code style. Run `just check-rust test-rust` and fix any problems that come up.

Produce a report containing three sections:

- How it works
    - Include which modules were changed or modified and how.
    - Check if the PR description matches the code.
- Any bugs or issues
    - Run tests to confirm that they work as expected and add more if there are gaps in the coverage.
      Tell me if they pass. If they do not, explain why simply.
- How the PR could be simplified
    - Does it contain unnecessary changes?
    - Could it be reworked to a simpler solution?
