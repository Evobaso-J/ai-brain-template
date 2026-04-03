# Agents Module

Automation scripts for recurring tasks.

## Scripts

| Script | Purpose | When to run |
|--------|---------|-------------|
| `scripts/weekly_review.py` | Generate weekly review from data across modules | Every Sunday |
| `scripts/content_ideas.py` | Surface content ideas from bookmarks and notes | When stuck for ideas |
| `scripts/stale_contacts.py` | Find inner/active contacts overdue for outreach | Weekly |

## Usage

```bash
python agents/scripts/weekly_review.py
python agents/scripts/content_ideas.py
python agents/scripts/stale_contacts.py
```

## Instructions

<instructions>
- Scripts are read-only by default — they surface insights, they do not write data.
- After running a script, the human decides what actions to take and logs them in the relevant module.
- Scripts should be run from the repo root.
</instructions>
