--- 
description: Review A PR
argument-hint: "<PR NUMBER>"
---

Please review PR #$@ by diffing it against `master`.

If it contains changes to rules, test it and try to find an example of a false-positive.
Otherwise, look for correctness and code style. Run `just check-rust test-rust` and fix any problems that come up.
