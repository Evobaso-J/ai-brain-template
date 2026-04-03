# Knowledge Module

Personal knowledge base: bookmarks, learning tracks, research notes, and quick captures.

## Files

| File | Purpose |
|------|---------|
| `bookmarks.jsonl` | Saved resources — articles, tools, repos, papers |
| `learning.yaml` | Skills tracker and learning goals |
| `competitors.md` | Reference projects and landscape analysis |
| `research/` | Topic deep-dives linking relevant bookmarks |
| `notes/` | Quick captures and fleeting thoughts |

## Schema

**bookmarks.jsonl**
```json
{"id": "bk_YYYYMMDD_HHMMSS", "url": "...", "title": "...", "category": "...", "tags": ["..."], "status": "unread|read|reviewed|archived", "rating": 0, "summary": "...", "why_saved": "...", "saved": "YYYY-MM-DD"}
```

## Categories

Use one primary category per bookmark:

- `ai-agents` — LLM tooling, agents, context engineering
- `architecture` — system design, patterns, distributed systems
- `frontend` — UI, React, browser APIs, CSS
- `backend` — APIs, databases, infrastructure
- `devops` — CI/CD, containers, cloud, observability
- `security` — auth, vulnerabilities, hardening
- `tooling` — dev tools, editors, CLIs, productivity
- `career` — growth, management, communication
- `open-source` — OSS strategy, community, contribution
- `research` — papers, deep technical topics

## Preferred tags

Lowercase, singular. Reuse existing tags when possible.

Common: `typescript`, `javascript`, `rust`, `go`, `python`, `react`, `node`, `postgres`, `redis`, `docker`, `kubernetes`, `llm`, `testing`, `performance`, `refactoring`, `api-design`

## Workflows

**Save a bookmark:**
1. Extract URL and title (infer from URL if not provided)
2. Assign category + at least 2 tags
3. Add `why_saved`: why this matters, not just what it is
4. Set `status: unread` initially
5. Check for duplicate URL before appending to `bookmarks.jsonl`

**Search bookmarks:**
1. Read `bookmarks.jsonl` line by line
2. Filter by category or tag match
3. Return title + URL + why_saved

**Research a topic:**
1. Search bookmarks by relevant tags/category
2. Summarize what's saved
3. Create a note in `research/TOPIC.md` if synthesizing
4. Note gaps worth filling

## Instructions

<instructions>
- Never save duplicate URLs. Check before appending.
- why_saved is mandatory — captures intent, not just content.
- rating 1–5: 1 = marginally useful, 5 = essential reference.
- notes/ files are quick-capture, no structure required.
- research/ files are synthesized, link back to bookmarks by ID.
- Cross-reference with content/ideas.jsonl — bookmarks often trigger content ideas.
</instructions>
