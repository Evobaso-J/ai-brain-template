# Network Module

Developer relationship management: contacts, interactions, and relationship tiers.

## Files

| File | Purpose |
|------|---------|
| `contacts.jsonl` | People database with context and relationship data |
| `interactions.jsonl` | Meeting and conversation log |
| `circles.yaml` | Relationship tier definitions and touchpoint frequency |
| `intros.md` | Introductions made or pending |

## Schema

**contacts.jsonl**
```json
{"id": "ct_YYYYMMDD_HHMMSS", "name": "...", "role": "...", "company": "...", "circle": "inner|active|network|dormant", "how_met": "...", "can_help_with": ["..."], "you_can_help_with": ["..."], "tags": ["..."], "linkedin": "...", "github": "...", "notes": "...", "created": "YYYY-MM-DD", "last_contact": "YYYY-MM-DD"}
```

**interactions.jsonl**
```json
{"id": "ix_YYYYMMDD_HHMMSS", "contact_id": "...", "contact_name": "...", "date": "YYYY-MM-DD", "type": "chat|call|meeting|email|collab|event", "summary": "...", "action_items": ["..."], "sentiment": "positive|neutral|follow-up-needed"}
```

## Relationship Circles

| Circle | Description | Touchpoint |
|--------|-------------|------------|
| `inner` | Close collaborators, friends in tech, trusted mentors | Weekly |
| `active` | Current project partners, active collaborators | Monthly |
| `network` | Industry connections, periodic contacts | Quarterly |
| `dormant` | Historical connections worth reactivating | As needed |

## Workflows

**Add a contact:**
1. Confirm: name, role, company, circle, how you met
2. Note mutual value: can_help_with ↔ you_can_help_with
3. Check for existing entry by name before appending
4. Append to `contacts.jsonl`

**Prep for a meeting:**
1. Search `contacts.jsonl` by name
2. Read `interactions.jsonl` filtered by contact_id
3. Surface last interaction, open action items, sentiment
4. Generate a brief: talking points, what to follow up on

**Log an interaction:**
1. Find contact_id in `contacts.jsonl`
2. Append to `interactions.jsonl` with date, type, summary
3. List any action items
4. Update `last_contact` in contacts entry (append new entry, latest wins)

**Find stale contacts:**
1. Filter `contacts.jsonl` by circle `inner|active`
2. Check `last_contact` date — flag if overdue per circle frequency
3. Run `agents/scripts/stale_contacts.py` for automated report

## Core Philosophy

- Give before you ask — lead with value, not requests
- Quality over quantity — meaningful connections over large networks
- Follow through consistently — every commitment honored
- Warm > cold — always seek introductions over cold outreach

## Instructions

<instructions>
- Never add a contact without recording how you met — context decays fast.
- Action items from interactions should be tracked in operations/todos.md too if they're commitments.
- Stale = inner circle not contacted in 2+ weeks, active in 6+ weeks, network in 4+ months.
- Interactions are append-only — never modify past entries.
</instructions>
