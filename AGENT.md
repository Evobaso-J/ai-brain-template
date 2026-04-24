# AI Brain — Agent Instructions

Routing: see `SKILL.md`. This file defines behavioral rules, conventions, and the request → action decision table.

## Core Rules

1. **Route first.** Read `SKILL.md` before loading any data. Identify the module.
2. **Load lazily.** Never load every module. Read only what the current task needs.
3. **Voice first.** Read `identity/voice.md` before drafting any content for external audiences.
4. **Append only.** JSONL files are append-only — mark as `"status": "archived"` instead of deleting.
5. **Rationale required.** Decisions and ADRs must include a `rationale` field. Reject incomplete entries.
6. **Explicit priority.** Tasks must carry P0/P1/P2/P3. Ask if not provided.
7. **Read before write.** Before appending to a data file, confirm the entry doesn't already exist.
8. **Cross-reference modules.** Knowledge informs content; network informs operations; engineering informs identity.
9. **Update timestamps.** Set the `updated` field when modifying any tracked entry.

## Quick Reference

- **Content** → read `identity/voice.md`, match patterns in `content/posts.jsonl`, draft, log
- **Contact lookup** → `network/contacts.jsonl` + `network/interactions.jsonl`
- **Content idea** → append to `content/ideas.jsonl`
- **Task / todo** → append to `operations/todos.md` under priority bucket
- **Weekly review** → `python agents/scripts/weekly_review.py`
- **What am I working on** → `engineering/projects.jsonl` filter `status: active`

## File Conventions

- **`.jsonl`** — one JSON object per line, append-only, schema comment on line 1
- **`.yaml`** — structured configuration, human-readable hierarchy
- **`.md`** — narrative content, freely editable, headers mark sections
- **`templates/`** — reusable formats, do not modify directly

### ID Format

All new JSONL entries use `{type}_{YYYYMMDD}_{HHMMSS}` as `id`. Example: `contact_20260423_174200`.

### Priority Levels

| Level | Meaning | Timeline |
|-------|---------|----------|
| P0 | Critical / blocking | Today |
| P1 | Important | This week |
| P2 | Planned | This month |
| P3 | Backlog | No deadline |

## When User Asks To…

| User says | Action sequence |
|-----------|----------------|
| "Add contact / save person" | Confirm name, role, how met → append to `network/contacts.jsonl` |
| "Prep for meeting with Y" | Read `network/contacts.jsonl` (filter by name) → read `network/interactions.jsonl` → check `operations/todos.md` for pending items → summarize |
| "Save bookmark / save this link" | Extract URL + title → assign tags → append to `knowledge/bookmarks.jsonl` |
| "Add a task / todo / remind me" | Ask priority if not given (P0–P3) → append to `operations/todos.md` |
| "Log a decision" | Confirm rationale is present → append to `operations/decisions.jsonl` |
| "What are my priorities?" | Read `operations/todos.md` → group by P0/P1/P2/P3 → show P0 first |
| "What am I working on?" | Read `engineering/projects.jsonl` → filter `status: active` → sort by `next_action` presence → show blockers |
| "What's in my stack?" | Read `engineering/stack.jsonl` → group by type |
| "I have an idea / project idea" | Check `engineering/ideas.jsonl` for duplicates → append with `status: raw` |
| "Add project" | Confirm name/status/stack → append to `engineering/projects.jsonl` |
| "Who am I / my background / my skills" | Read `identity/IDENTITY.md` → load `identity/voice.md` and `identity/brand.md` |
| "Log an ADR / architecture decision" | Confirm context + decision + consequences → append to `engineering/decisions.jsonl` |
| "Debug playbook for X" | Read `engineering/playbooks.jsonl` → filter by symptoms/tags → if none found, offer to create one |
| "What patterns do I use for X?" | Read `engineering/stack.jsonl` + `engineering/playbooks.jsonl` → summarize |
| "Prep for code review" | Read `engineering/reviews.jsonl` → filter by category/tags → present grouped by severity |
| "Write a post about X" | Read `identity/voice.md` → check `identity/brand.md` for pillar alignment → draft → log to `content/ideas.jsonl` or `content/posts.jsonl` |
| "Weekly review" | Run `agents/scripts/weekly_review.py` → review `operations/metrics.jsonl` → check stale contacts → update `operations/goals.yaml` → plan `content/calendar.md` |
