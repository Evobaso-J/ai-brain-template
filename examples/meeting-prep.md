# Example: Meeting Preparation Workflow

A walkthrough of preparing for a 1:1 with a collaborator you haven't spoken to in a while.

---

## Scenario

You have a call with someone from your network in 30 minutes.

## Step 1: Look up the contact

```
Read network/contacts.jsonl → filter by name
```

Get their role, company, circle tier, mutual value, and any notes.

## Step 2: Pull interaction history

```
Read network/interactions.jsonl → filter by contact_id
```

Surface the last 2–3 interactions: what was discussed, sentiment, and open action items.

## Step 3: Check open action items

Any items from past meetings that were never logged as done? Check `operations/todos.md` for tasks referencing this contact.

## Step 4: Generate a brief

Based on the above, produce a pre-meeting summary:

```
Contact: [Name], [Role] @ [Company]
Last spoke: [date] — [summary]
Open items: [list]
Suggested talking points:
  - Follow up on: [X]
  - Share: [Y from your current work]
  - Ask about: [Z based on their expertise]
```

## Step 5: After the meeting

Append to `network/interactions.jsonl`:

```json
{"id": "ix_20260401_110000", "contact_id": "ct_...", "contact_name": "...", "date": "2026-04-01", "type": "call", "summary": "...", "action_items": ["..."], "sentiment": "positive"}
```

Add action items to `operations/todos.md` with appropriate priority.

---

**Token cost for this workflow:** ~350 tokens (1 contact entry + 3 interaction entries)
