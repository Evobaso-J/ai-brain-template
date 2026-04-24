---
name: ai-brain
description: This skill should be used when the user asks to "add a task", "log a decision", "save bookmark", "prep for meeting", "weekly review", "write a post", "check my voice", "add a project", "log an ADR", "debug playbook", or mentions personal brand, content, network, operations, or engineering context.
version: 1.0.0
---

# AI Brain

A personal context OS for a software engineer. Manages identity, content, knowledge, network, operations, and engineering context with AI assistance through progressive disclosure.

**Important**: This skill uses progressive disclosure. Module-specific instructions are in each subdirectory's `.md` file. Only load what's needed for the current task.

## When to Activate

Activate this skill when the user:

- Requests content creation (posts, threads, talks, newsletters) — load `identity/voice.md` first
- Asks about personal brand, positioning, or bio
- Wants to look up or manage contacts and relationships
- Needs meeting preparation or follow-up
- Asks for weekly reviews or goal tracking
- Needs to save bookmarks or research notes
- Logs tasks, priorities, or decisions
- Captures project ideas, ADRs, stack entries, or debugging playbooks
- Asks "what am I working on" / "what's in my stack"

**Trigger phrases**: "add a task", "my priorities", "log a decision", "save this link", "prep for meeting with X", "who is Y", "weekly review", "write a post", "my voice", "add a project", "what am I working on", "log an ADR", "debug playbook".

## Core Concepts

### Progressive Disclosure Architecture

| Level | When Loaded | Content |
|-------|-------------|---------|
| **L1: Metadata** | Always | This `SKILL.md` — routing + activation |
| **L2: Module Instructions** | On-demand | `[module]/[MODULE].md` per domain |
| **L3: Data Files** | As-needed | `.jsonl`, `.yaml`, `.md` entries |

Max 2 hops from request to data.

### File Format Strategy

- **JSONL** (`.jsonl`): append-only logs — ideas, posts, contacts, interactions, decisions, projects, stack, playbooks, reviews
- **YAML** (`.yaml`): structured configs — goals, values, circles, learning
- **Markdown** (`.md`): narrative content — voice, brand, calendar, todos, notes
- **XML** (`.xml`): complex prompts — content generation templates

### Append-Only Data Integrity

JSONL files are **append-only**. Never delete entries:
- Mark as `"status": "archived"` instead of removing
- Preserves history for retrospectives and pattern analysis

## Detailed Topics

### Module Overview

```
ai-brain/
├── identity/      → Voice, brand, values (READ FIRST for content)
├── content/       → Ideas, drafts, posts, calendar
├── knowledge/     → Bookmarks, research, learning
├── network/       → Contacts, interactions, intros
├── operations/    → Todos, goals, decisions, meetings, metrics
├── engineering/   → Projects, ideas, stack, ADRs, playbooks, reviews
└── agents/        → Automation scripts
```

### Identity Module (Critical for Content)

**Always read `identity/voice.md` before generating any content.**

Contains:
- `voice.md` — tone, style, vocabulary, patterns
- `brand.md` — positioning, audience, content pillars
- `values.yaml` — core principles
- `bio-variants.md` — platform-specific bios
- `prompts/` — reusable generation templates

### Content Module

Pipeline: `ideas.jsonl` → `drafts/` → `posts.jsonl`

- Capture ideas immediately to `ideas.jsonl`
- Develop in `drafts/` using `templates/`
- Log published content to `posts.jsonl` with metrics
- Plan in `calendar.md`

### Network Module

Personal CRM with relationship tiers (defined in `circles.yaml`):
- `inner` — weekly touchpoints
- `active` — bi-weekly
- `network` — monthly
- `dormant` — quarterly reactivation

### Operations Module

Productivity system with explicit priority levels:
- **P0** — critical / blocking / today
- **P1** — important / this week
- **P2** — planned / this month
- **P3** — backlog / no deadline

### Engineering Module

Builder's log:
- `projects.jsonl` — active and past projects with status
- `ideas.jsonl` — raw project ideas (check for duplicates before append)
- `stack.jsonl` — tools, languages, frameworks
- `decisions.jsonl` — Architecture Decision Records (context + decision + consequences required)
- `playbooks.jsonl` — debugging playbooks keyed by symptoms/tags
- `reviews.jsonl` — code review checks and anti-patterns

## Practical Guidance

### Content Creation Workflow

```
1. Read identity/voice.md (REQUIRED)
2. Check identity/brand.md for pillar alignment
3. Reference content/posts.jsonl for successful patterns
4. Use content/templates/ as starting structure
5. Draft matching voice attributes
6. Log to posts.jsonl after publishing
```

### Pre-Meeting Preparation

```
1. Look up contact: network/contacts.jsonl
2. Get history: network/interactions.jsonl
3. Check pending: operations/todos.md
4. Generate brief with context
```

### Weekly Review Process

```
1. Run: python agents/scripts/weekly_review.py
2. Review metrics in operations/metrics.jsonl
3. Check stale contacts: agents/scripts/stale_contacts.py
4. Update goals progress in operations/goals.yaml
5. Plan next week in content/calendar.md
```

### Log an ADR

```
1. Confirm context + decision + consequences are all present
2. Assign rationale
3. Append to engineering/decisions.jsonl
```

## Examples

### Example: Add a Task

**Input**: "Remind me to ship the caveman plugin this week"

**Process**:
1. Ask priority (P0–P3) if not given
2. Append to `operations/todos.md` under the correct priority section
3. Confirm saved

### Example: Contact Lookup

**Input**: "Prepare me for my call with Sarah Chen"

**Process**:
1. Search `network/contacts.jsonl` for "Sarah Chen"
2. Pull recent entries from `network/interactions.jsonl`
3. Check `operations/todos.md` for pending items involving Sarah
4. Compile brief: role, context, last discussed, follow-ups

## Guidelines

1. **Voice First** — read `identity/voice.md` before any content generation
2. **Append Only** — never delete JSONL entries; archive instead
3. **Rationale Required** — decisions/ADRs must include `rationale`
4. **Explicit Priority** — tasks must carry P0/P1/P2/P3; ask if missing
5. **ID Format** — `{type}_{YYYYMMDD}_{HHMMSS}` for all new entries
6. **Read Before Write** — check for duplicates before appending
7. **Cross-Reference** — knowledge informs content, network informs operations, engineering informs identity
8. **Update Timestamps** — set `updated` when modifying tracked data

## References

Internal:
- [Identity Module](./identity/IDENTITY.md)
- [Content Module](./content/CONTENT.md)
- [Knowledge Module](./knowledge/KNOWLEDGE.md)
- [Network Module](./network/NETWORK.md)
- [Operations Module](./operations/OPERATIONS.md)
- [Engineering Module](./engineering/ENGINEERING.md)
- [Agent Scripts](./agents/AGENTS.md)
- [Behavioral Rules](./AGENT.md)
- [File Schemas](./references/file-formats.md)

External:
- [Agent Skills for Context Engineering](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) — structural reference
- [Anthropic Context Engineering Guide](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
