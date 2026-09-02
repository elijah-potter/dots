---
description: Read all open PRs and filter using guided judgement.
---

Using the `gh` command, read all open PRs. Produce two lists.

Neither list should:
- Include draft PRs.

The first list should contain only 'slam dunks'.
These are PRs that are very easy to review and require very little followup.
This list should contain 10 items.

The second list should contain the highest impact PRs available.
They may take some time to review, but either add significant functionality or eliminate long-standing high-impact bugs.
This list should contain 3 items.

Provide:

- The module(s) affected by the PR (including exact file paths). 
- Whether the checks for that PR passed.
- The PR's URL

If a PR is written by an agent, it is in-policy to declare so in the description.
Do not include PRs written primarily agents, unless there are no other PRs remaining to fill the quota.

The goal here is to sample from the pareto frontier of PRs that take time to review but also have the highest impact.
Please use judgement to identify PRs that (for the given amount of effort needed to review) return the highest end-impact for the user.
