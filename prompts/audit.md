---
description: "Perform an in-depth audit of a repository's static analysis tools and build system."
---

Check that the following are true, one by one.

- Any and all static analysis tools configured in this repository must be run by CI.
    - Report by providing a list of static analysis tools with a check mark or "X" for whether they are in use.
- All artifacts that _can_ be produced by this repository _are_ built at least once in CI.
    - Report by providing a list of artifacts with a check mark or "X" for whether they are built.

If any are not true, please report where work must be done.
Do not do any work yourself. Consider this an audit.

