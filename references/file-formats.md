# File Formats Reference

Complete schema specifications for all data files in the AI Brain.

## JSONL Conventions

- First line is always a schema comment: `{"_schema": "field1|field2|..."}`
- One JSON object per line after that
- Append-only — never overwrite or delete entries
- Archived entries: add `"archived": true` and `"archived_date": "YYYY-MM-DD"`
- ID format: `{type}_{YYYYMMDD}_{HHMMSS}` (e.g. `idea_20260401_090000`)

---

## content/ideas.jsonl

```json
{
  "id": "idea_YYYYMMDD_HHMMSS",
  "title": "string",
  "format": "thread|post|talk|oss-doc|newsletter",
  "pillar": "string — maps to identity/brand.md content pillars",
  "status": "raw|developing|ready|published|archived",
  "priority": "P0|P1|P2|P3",
  "source": "string — where the idea came from",
  "notes": "string — angle, hook, key argument",
  "created": "YYYY-MM-DD",
  "updated": "YYYY-MM-DD"
}
```

## content/posts.jsonl

```json
{
  "id": "post_YYYYMMDD_HHMMSS",
  "title": "string",
  "format": "thread|post|talk|oss-doc|newsletter",
  "platform": "twitter|linkedin|blog|github|conference",
  "url": "string",
  "published": "YYYY-MM-DD",
  "impressions": 0,
  "engagement": 0,
  "notes": "string",
  "pillar": "string"
}
```

## content/engagement.jsonl

```json
{
  "id": "eng_YYYYMMDD_HHMMSS",
  "url": "string",
  "title": "string",
  "author": "string",
  "why_saved": "string — what makes this reference-worthy",
  "saved": "YYYY-MM-DD"
}
```

---

## knowledge/bookmarks.jsonl

```json
{
  "id": "bk_YYYYMMDD_HHMMSS",
  "url": "string",
  "title": "string",
  "category": "ai-agents|architecture|frontend|backend|devops|security|tooling|career|open-source|research",
  "tags": ["string"],
  "status": "unread|read|reviewed|archived",
  "rating": 1,
  "summary": "string — what it is",
  "why_saved": "string — why it matters to you",
  "saved": "YYYY-MM-DD"
}
```

---

## network/contacts.jsonl

```json
{
  "id": "ct_YYYYMMDD_HHMMSS",
  "name": "string",
  "role": "string",
  "company": "string",
  "circle": "inner|active|network|dormant",
  "how_met": "string",
  "can_help_with": ["string"],
  "you_can_help_with": ["string"],
  "tags": ["string"],
  "linkedin": "url or null",
  "github": "url or null",
  "notes": "string",
  "created": "YYYY-MM-DD",
  "last_contact": "YYYY-MM-DD"
}
```

## network/interactions.jsonl

```json
{
  "id": "ix_YYYYMMDD_HHMMSS",
  "contact_id": "ct_...",
  "contact_name": "string",
  "date": "YYYY-MM-DD",
  "type": "chat|call|meeting|email|collab|event",
  "summary": "string",
  "action_items": ["string"],
  "sentiment": "positive|neutral|follow-up-needed"
}
```

---

## operations/decisions.jsonl

```json
{
  "id": "dec_YYYYMMDD_HHMMSS",
  "title": "string — short description of what was decided",
  "decision": "string — the actual choice made",
  "rationale": "string — required: why this over alternatives",
  "date": "YYYY-MM-DD",
  "outcome": "pending|good|bad|mixed|n/a",
  "tags": ["string"]
}
```

## operations/meetings.jsonl

```json
{
  "id": "mtg_YYYYMMDD_HHMMSS",
  "date": "YYYY-MM-DD",
  "attendees": ["string"],
  "topic": "string",
  "decisions": ["string"],
  "action_items": ["string"],
  "notes": "string"
}
```

## operations/metrics.jsonl

```json
{
  "id": "met_YYYYMMDD_HHMMSS",
  "week": "YYYY-Www",
  "engineering": {
    "prs_merged": 0,
    "reviews_done": 0,
    "incidents": 0
  },
  "content": {
    "posts_published": 0,
    "ideas_captured": 0
  },
  "network": {
    "meaningful_convos": 0,
    "intros_made": 0
  },
  "learning": {
    "hours": 0,
    "skills_practiced": []
  },
  "notes": "string"
}
```

---

## engineering/projects.jsonl

```json
{
  "id": "proj_YYYYMMDD_HHMMSS",
  "name": "string",
  "status": "active|paused|done|abandoned",
  "stack": ["string"],
  "repo": "url or null",
  "description": "string",
  "next_action": "string — immediate next step",
  "blockers": "string or null — what's preventing progress",
  "links": ["url — PRs, docs, Linear, Figma, etc."],
  "goals_ref": "string or null — objective ID from goals.yaml",
  "notes": "string",
  "created": "YYYY-MM-DD",
  "updated": "YYYY-MM-DD"
}
```

## engineering/ideas.jsonl

```json
{
  "id": "idea_YYYYMMDD_HHMMSS",
  "title": "string",
  "status": "raw|exploring|ready|promoted|shelved",
  "stack": ["string"],
  "notes": "string",
  "created": "YYYY-MM-DD",
  "updated": "YYYY-MM-DD"
}
```

## engineering/stack.jsonl

```json
{
  "id": "stk_YYYYMMDD_HHMMSS",
  "name": "string",
  "type": "language|framework|tool|infra|platform|library",
  "proficiency": "expert|proficient|learning",
  "notes": "string",
  "added": "YYYY-MM-DD"
}
```

## engineering/decisions.jsonl

```json
{
  "id": "adr_YYYYMMDD_HHMMSS",
  "title": "string — short description of the architectural choice",
  "status": "proposed|accepted|superseded|deprecated",
  "context": "string — what is motivating this decision",
  "decision": "string — the change being made",
  "rationale": "string — required: why this over alternatives",
  "consequences_positive": ["string"],
  "consequences_negative": ["string"],
  "risks": ["string"],
  "supersedes": "adr_... or null",
  "date": "YYYY-MM-DD"
}
```

## engineering/playbooks.jsonl

```json
{
  "id": "pb_YYYYMMDD_HHMMSS",
  "title": "string",
  "symptoms": ["string — observable signs of the problem"],
  "root_cause": "string",
  "fix": "string",
  "tags": ["string"],
  "created": "YYYY-MM-DD"
}
```

## engineering/reviews.jsonl

```json
{
  "id": "rv_YYYYMMDD_HHMMSS",
  "check": "string — what to look for",
  "category": "correctness|security|performance|maintainability|operational-readiness|anti-pattern",
  "type": "checklist|anti-pattern",
  "severity": "critical|high|medium|low",
  "tags": ["string"],
  "created": "YYYY-MM-DD"
}
```

---

## YAML File Purposes

| File | Contains |
|------|---------|
| `identity/values.yaml` | Core engineering values, principles, working style |
| `operations/goals.yaml` | Quarterly OKRs with key results and progress |
| `knowledge/learning.yaml` | Skills with proficiency levels and learning goals |
| `network/circles.yaml` | Relationship tier definitions and member lists |
