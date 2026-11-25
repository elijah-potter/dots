---
description: Fuzz one Harper rule against the local corpus
argument-hint: "<RULE_NAME> [FILES...]"
---

Fuzz one Harper rule against the local corpus in `~/Projects/harper-llm-fuzz` and inspect likely false positives.

## Arguments

- Rule name: `$1`
- Optional scoped files: `${@:2}`

If no rule name is provided, ask for the exact Harper rule name before running anything.
Default to the full `perfection/*.md` corpus unless the user explicitly provided file arguments or asked for a narrower sample.

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
   Always fuzz a single rule with `--only` via `check.sh`. Do not run the whole rule set, because unrelated lints like spelling can pollute the results.

   For the default full-corpus run:

   ```bash
   cd ~/Projects/harper-llm-fuzz
   ./check.sh $1
   ```

   If the user explicitly wants a scoped run, pass file arguments after the rule name:

   ```bash
   cd ~/Projects/harper-llm-fuzz
   ./check.sh $1 ${@:2}
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
- `check.sh` scans `perfection/*.md` by default.
- `harper-cli` may load the user dictionary from `~/.config/harper-ls/dictionary.txt`, which can affect results.
- After finding suspicious matches, inspect the rule implementation and add regression tests before changing behavior.
