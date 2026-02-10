---
name: weir-rule-writer
description: Write and update Weir language rules for Harper style guides. Use when asked to create, modify, or review Weir rules, expressions, replacements, or tests; when drafting style-guide enforcement rules; or when clarifying Weir syntax for a rule.
---

# Weir Rule Writer

## Overview
Create correct, test-heavy Weir rules for Harper with clear messages, descriptions, kinds, replacements, and validation tests.

## Workflow

1. Draft the core expression
- Encode the match with `expr main` using words, sequences, alternatives, filters, exceptions, POS tags, wildcards, or punctuation.
- Keep the expression minimal but precise; avoid overmatching.
- If a wordlist is needed, include it as its own expression, used with an expression reference.

2. Add rule metadata
- `let message`, `let description`, `let kind`, `let becomes` (and `let strategy` if needed).
- Use `strategy "Exact"` when casing must be normalized; otherwise default behavior or `MatchCase` as appropriate.

3. Add tests (required)
- Include at least 15 tests.
- Tests must cover: true positives, false positives, false negatives, and (if relevant) true negatives.
- Prefer a mix of casing, punctuation, whitespace, and nearby-token variations.

4. Sanity-check edge cases
- Ensure exceptions do not block valid matches.
- Ensure replacements are correct and not destructive.

5. Run the tests.
- Fix any issues that arise.

## Output Format

Write a Weir rule to a new file with a name of your choosing, including `expr main`, `let` fields, and tests. Make sure it has the extension `.weir`.

## References
- Use `references/weir.md` for Weir language syntax and examples.
