# Engineering Module

Active projects, tech stack, architecture decisions, debugging playbooks, and development workflows.

## Files

| File | Purpose |
|------|---------|
| `ideas.jsonl` | Project ideas — raw, exploring, or shelved |
| `projects.jsonl` | Active and past projects with status and context |
| `stack.jsonl` | Tech stack: languages, frameworks, tools, infrastructure |
| `decisions.jsonl` | Architecture Decision Records (ADRs) — append-only |
| `playbooks.jsonl` | Debugging playbooks — recurring patterns, incident learnings |
| `reviews.jsonl` | Code review checks and anti-patterns — append-only |

## Schema

**projects.jsonl**
```json
{"id": "proj_YYYYMMDD_HHMMSS", "name": "...", "status": "active|paused|done|abandoned", "stack": ["..."], "repo": "url or null", "description": "...", "next_action": "...", "blockers": "... or null", "links": ["url1", "url2"], "goals_ref": "objective ID from goals.yaml or null", "notes": "...", "created": "YYYY-MM-DD", "updated": "YYYY-MM-DD"}
```

**ideas.jsonl**
```json
{"id": "idea_YYYYMMDD_HHMMSS", "title": "...", "status": "raw|exploring|ready|promoted|shelved", "stack": ["..."], "notes": "...", "created": "YYYY-MM-DD", "updated": "YYYY-MM-DD"}
```

**stack.jsonl**
```json
{"id": "stk_YYYYMMDD_HHMMSS", "name": "...", "type": "language|framework|tool|infra|platform|library", "proficiency": "expert|proficient|learning", "notes": "...", "added": "YYYY-MM-DD"}
```

**decisions.jsonl**
```json
{"id": "adr_YYYYMMDD_HHMMSS", "title": "...", "status": "proposed|accepted|superseded|deprecated", "context": "...", "decision": "...", "rationale": "why this over alternatives", "consequences_positive": ["..."], "consequences_negative": ["..."], "risks": ["..."], "supersedes": "adr_... or null", "date": "YYYY-MM-DD"}
```

**playbooks.jsonl**
```json
{"id": "pb_YYYYMMDD_HHMMSS", "title": "...", "symptoms": ["..."], "root_cause": "...", "fix": "...", "tags": ["..."], "created": "YYYY-MM-DD"}
```

## Proficiency Levels

| Level | Meaning |
|-------|---------|
| `expert` | 5+ years, deep knowledge — assume full familiarity |
| `proficient` | 2–5 years, solid — may need occasional reminders |
| `learning` | < 2 years — explain from first principles |

## Workflows

**Summarize active work:**
1. Read `projects.jsonl`
2. Filter `status: active`
3. Present as a short list with stack and next action from notes

**Add a project:**
1. Confirm: name, status, stack array, repo, description
2. Check for existing entry by name before appending
3. Append to `projects.jsonl`

**Update a project:**
1. Find entry by name
2. Append a new entry with updated fields — latest entry wins

**Recommend a tool or library:**
1. Read `stack.jsonl` first
2. Prefer tools already in the stack
3. Only suggest new tools if nothing existing fits — note it as `learning` if unfamiliar

**Capture a project idea:**
1. Check `ideas.jsonl` for existing similar idea
2. Append with `status: raw`
3. When ready to start, promote to `projects.jsonl` and set idea status to `promoted`

**Log an architecture decision:**
1. Read `decisions.jsonl` to check for duplicates
2. Confirm: context, decision, consequences (positive + negative)
3. Append with `status: proposed` — user promotes to `accepted`

**Record a debugging playbook:**
1. Read `playbooks.jsonl` for existing playbook with similar symptoms
2. If found, append updated entry (latest wins). If new, append fresh entry
3. Must include: symptoms, root cause, fix, tags

**Prep for code review:**
1. Read `reviews.jsonl`
2. Filter by `category` or `tags` relevant to the PR's domain
3. Present checks grouped by category, highest severity first

## Instructions

<instructions>
- Always check stack.jsonl before recommending tools — prefer what you already use.
- Never create duplicate project entries. Check by name before adding.
- When writing or reviewing code, apply proficiency levels from stack.jsonl to calibrate explanations.
- Status values: active | paused | done | abandoned
- Cross-reference with operations/goals.yaml — projects should map to objectives via `goals_ref`.
- ADRs are for non-obvious architectural choices. Don't create one for standard/obvious decisions.
- Playbooks are for patterns you've hit more than once, or incidents expensive enough to document after the first time.
</instructions>
