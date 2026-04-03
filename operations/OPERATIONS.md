# Operations Module

Personal productivity: tasks, goals, decisions, meetings, and metrics.

## Files

| File              | Purpose                              |
| ----------------- | ------------------------------------ |
| `todos.md`        | Active task list grouped by priority |
| `goals.yaml`      | OKRs and objectives (quarterly)      |
| `decisions.jsonl` | Decisions log with rationale         |
| `meetings.jsonl`  | Meeting logs with action items       |
| `metrics.jsonl`   | Weekly performance metrics           |
| `reviews/`        | Periodic review documents            |

## Schema

**decisions.jsonl**

```json
{
  "id": "dec_YYYYMMDD_HHMMSS",
  "title": "...",
  "decision": "...",
  "rationale": "...",
  "date": "YYYY-MM-DD",
  "outcome": "pending|good|bad|mixed|n/a",
  "tags": ["..."]
}
```

**meetings.jsonl**

```json
{
  "id": "mtg_YYYYMMDD_HHMMSS",
  "date": "YYYY-MM-DD",
  "attendees": ["..."],
  "topic": "...",
  "decisions": ["..."],
  "action_items": ["..."],
  "notes": "..."
}
```

**metrics.jsonl**

```json
{
  "id": "met_YYYYMMDD_HHMMSS",
  "week": "YYYY-Www",
  "engineering": { "prs_merged": 0, "reviews_done": 0, "incidents": 0 },
  "content": { "posts_published": 0, "ideas_captured": 0 },
  "network": { "meaningful_convos": 0, "intros_made": 0 },
  "learning": { "hours": 0, "skills_practiced": [] },
  "notes": "..."
}
```

## Priority System

| Level | Meaning             | Timeline    |
| ----- | ------------------- | ----------- |
| P0    | Critical / blocking | Today       |
| P1    | Important           | This week   |
| P2    | Planned             | This month  |
| P3    | Backlog             | No deadline |

## Workflows

**Add a task:**

1. Identify priority (ask if not given)
2. Note any blocked dependencies
3. Append to `todos.md` under the right priority section

**Review priorities:**

1. Read `todos.md`
2. Show P0 → P1 → P2 → P3
3. Surface anything overdue

**Log a decision:**

1. Title: what was decided (short)
2. Decision: the actual choice
3. Rationale: required — why this choice over alternatives
4. Date: today
5. Outcome: `pending` initially
6. Append to `decisions.jsonl`

**Log a meeting:**

1. Date, attendees, topic
2. Capture decisions made and action items
3. Append to `meetings.jsonl`
4. Add action items to `todos.md` with owner and priority

**Weekly review:**

1. Run `agents/scripts/weekly_review.py`
2. Append metrics to `metrics.jsonl`
3. Save review doc to `reviews/YYYY-Www.md`

## Instructions

<instructions>
- Never add a task without a priority. Ask if not provided.
- Never log a decision without a rationale. Reject incomplete entries.
- Decisions are append-only — never delete or modify. Add a follow-up entry if outcome changes.
- Action items from meetings should cross-reference the meeting ID in their context.
- Weekly review is mandatory — treat it as P0 every Sunday.
</instructions>
