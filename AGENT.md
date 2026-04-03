# AGENT — Brain-Level Behavioral Rules

## Core Rules

1. **Route first.** Always read `SKILL.md` to identify the module before loading any data.
2. **Load lazily.** Never load all data files. Read only what the task requires.
3. **Append only.** JSONL files are append-only. Never overwrite or delete entries — mark as `archived` instead.
4. **Rationale required.** Decisions must include a `rationale` field. Reject incomplete entries.
5. **Priority is explicit.** Tasks must have a priority (P0/P1/P2/P3). Ask if not provided.
6. **IDs are timestamps.** Use `{type}_{YYYYMMDD}_{HHMMSS}` format for all new entries.
7. **Read before write.** Before appending to a data file, confirm the entry doesn't already exist.
8. **Voice first.** Read `identity/voice.md` before drafting any content for external audiences.
9. **Cross-reference modules.** Knowledge informs content, network informs operations, engineering informs identity.

## Quick Reference

| User says | Action sequence |
|-----------|----------------|
| "Add contact / save person" | Confirm name, role, how met → append to `network/contacts.jsonl` |
| "Prep for meeting with Y" | Read `network/contacts.jsonl` (filter by name) → read `network/interactions.jsonl` → summarize |
| "Save bookmark / save this link" | Extract URL + title → assign tags → append to `knowledge/bookmarks.jsonl` |
| "Add a task / todo / remind me" | Ask priority if not given (P0–P3) → append to `operations/todos.md` |
| "Log a decision" | Confirm rationale is present → append to `operations/decisions.jsonl` |
| "What are my priorities?" | Read `operations/todos.md` → group by P0/P1/P2/P3 → show P0 first |
| "What am I working on?" | Read `engineering/projects.jsonl` → filter `status: active` → summarize |
| "What's in my stack?" | Read `engineering/stack.jsonl` → group by type |
| "I have an idea / project idea" | Check `engineering/ideas.jsonl` for duplicates → append with `status: raw` |
| "Add project" | Confirm name/status/stack → append to `engineering/projects.jsonl` |
| "Who am I / my background / my skills" | Read `identity/IDENTITY.md` → load `identity/voice.md` and `identity/brand.md` |
| "Log an ADR / architecture decision" | Confirm context + decision + consequences → append to `engineering/decisions.jsonl` |
| "Debug playbook for X" | Read `engineering/playbooks.jsonl` → filter by symptoms/tags → if none found, offer to create one |
| "What patterns do I use for X?" | Read `engineering/stack.jsonl` + `engineering/playbooks.jsonl` → summarize |
| "Prep for code review" | Read `engineering/reviews.jsonl` → filter by relevant category/tags → present grouped by severity |
| "What should I work on?" | Read `engineering/projects.jsonl` → filter active → sort by `next_action` presence → show blockers |
| "Weekly review" | Run `agents/scripts/weekly_review.py` → present insights |

## File Conventions

- `.jsonl` — one JSON object per line, append-only, schema comment on first line
- `.yaml` — structured configuration, human-readable hierarchy
- `.md` — narrative content, freely editable, headers mark sections
- `templates/` — reusable formats, do not modify directly

## Priority Levels

| Level | Meaning | Timeline |
|-------|---------|----------|
| P0 | Critical / blocking | Today |
| P1 | Important | This week |
| P2 | Planned | This month |
| P3 | Backlog | No deadline |
