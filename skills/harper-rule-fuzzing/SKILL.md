---
name: harper-rule-fuzzing
description: Run a single Harper rule against the local `~/Projects/harper-llm-fuzz` corpus to surface likely false positives. By default, fuzz the full corpus for that one rule unless the user explicitly asks for a narrower file subset. Use this skill when a user wants to fuzz or validate one specific Harper rule, inspect corpus hits, or sanity-check a rule against broadly grammatical text without interference from unrelated rules.
---

# Harper Rule Fuzzing

## Overview

Use this skill to fuzz one Harper rule against the local corpus in `~/Projects/harper-llm-fuzz`.
By default, run the target rule across the full `perfection/*.md` corpus.
The goal is to find likely false positives in a large body of mostly grammatical text while avoiding noise from unrelated rules.

## Workflow

1. Identify the exact rule name.
Check the rule name in Harper config if needed:

```bash
harper-cli config | rg -n 'RuleNameHere'
```

2. Verify `harper-cli` is available.
If it is missing or the user explicitly wants a fresh install, run this from the Harper repository:

```bash
just install
```

3. Run only the target rule.
Always fuzz a single rule with `--only`. Do not run the whole rule set, because unrelated lints like spelling can pollute the results.
Default to the full corpus unless the user explicitly asks for a smaller sample or specific files.

```bash
cd ~/Projects/harper-llm-fuzz
./check.sh <RULE_NAME>
```

If the user explicitly wants a scoped run, pass file arguments after the rule name:

```bash
cd ~/Projects/harper-llm-fuzz
./check.sh <RULE_NAME> perfection/file-a.md perfection/file-b.md
```

4. Inspect the failures.
`check.sh` runs `harper-cli lint "$file" --only "$rule"` across `perfection/*.md` with GNU Parallel. On failure it prints the lint details and then opens the failing files in `nvim`.

5. Treat hits as leads, not truth.
The corpus is broadly grammatical, so hits are useful for finding suspicious behavior, but each match still needs review before changing the rule.

## Non-Interactive Use

`check.sh` opens `nvim` when it finds failing files. In an agent or CI-like session, avoid hanging on the editor.

Use a temporary `nvim` stub if you only need the file list and lint output:

```bash
mkdir -p /tmp/fakebin
printf '#!/bin/sh\nexit 0\n' > /tmp/fakebin/nvim
chmod +x /tmp/fakebin/nvim
PATH="/tmp/fakebin:$PATH" bash -lc 'cd ~/Projects/harper-llm-fuzz && ./check.sh <RULE_NAME>'
```

If you need to sample behavior without waiting for the full corpus run, you may wrap the command with `timeout`, but do not treat a timed-out run as a complete fuzz result.

## What To Look For

- Legitimate prose flagged by the target rule.
- Repeated patterns across multiple files.
- Cases where the rule message or suggestion is clearly wrong.
- Cases influenced by ambiguity, domain terminology, or formatting in markdown.

## Notes

- The corpus currently lives at `~/Projects/harper-llm-fuzz`.
- `check.sh` scans `perfection/*.md`.
- `harper-cli` may load the user dictionary from `~/.config/harper-ls/dictionary.txt`, which can affect results.
- After finding suspicious matches, inspect the rule implementation and add regression tests before changing behavior.

## Example Requests

- Fuzz `NeedToNoun` against the local corpus and show me the likely false positives.
- Use `$harper-rule-fuzzing` to validate whether a new rule is too aggressive.
- Run one Harper rule over `~/Projects/harper-llm-fuzz` and summarize the failing files.
