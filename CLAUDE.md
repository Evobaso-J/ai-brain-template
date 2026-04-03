# AI Brain — Personal Context OS

A personal AI OS for a software engineer. Gives Claude structured context using three levels of progressive loading to minimize token overhead.

## How to navigate

1. Read `SKILL.md` first — routes to the relevant module based on task type
2. Read the module's `.md` file for domain-specific instructions and context
3. Load `.jsonl` / `.yaml` data files only when the task requires specific entries

**Max 2 hops to any piece of information.**

## Structure

```
SKILL.md                          # L1: Always read first — routes by task type
AGENT.md                          # Brain-level behavioral rules + decision table

identity/
  IDENTITY.md                     # L2: Voice, brand, values, bio
  voice.md                        # Tone, vocabulary, writing patterns
  brand.md                        # Positioning, audience, pillars
  values.yaml                     # Core principles
  bio-variants.md                 # Platform-specific bios
  prompts/                        # Reusable generation templates

content/
  CONTENT.md                      # L2: Ideas, drafts, published posts
  ideas.jsonl                     # L3: Raw content ideas
  posts.jsonl                     # L3: Published content archive
  engagement.jsonl                # L3: Inspiring reference content
  calendar.md                     # Content schedule
  drafts/                         # WIP content
  templates/                      # Reusable formats

knowledge/
  KNOWLEDGE.md                    # L2: Bookmarks, learning, research
  bookmarks.jsonl                 # L3: Saved resources
  learning.yaml                   # Skills + learning goals
  competitors.md                  # Reference projects / landscape
  research/                       # Topic deep-dives
  notes/                          # Quick captures

network/
  NETWORK.md                      # L2: Contacts, interactions, relationships
  contacts.jsonl                  # L3: People database
  interactions.jsonl              # L3: Meeting/conversation log
  circles.yaml                    # Relationship tiers
  intros.md                       # Intro tracking

operations/
  OPERATIONS.md                   # L2: Tasks, goals, decisions, metrics
  todos.md                        # Active task list
  goals.yaml                      # OKRs and objectives
  meetings.jsonl                  # L3: Meeting logs
  metrics.jsonl                   # L3: Weekly performance metrics
  decisions.jsonl                 # L3: Decisions log with rationale
  reviews/                        # Periodic assessment docs

engineering/
  ENGINEERING.md                  # L2: Ideas, active projects, tech stack, workflows
  ideas.jsonl                     # L3: Project ideas
  projects.jsonl                  # L3: Active/past project entries
  stack.jsonl                     # L3: Tools, languages, frameworks
  decisions.jsonl                 # L3: Architecture Decision Records
  playbooks.jsonl                 # L3: Debugging playbooks
  reviews.jsonl                    # L3: Code review checks and anti-patterns

agents/
  AGENTS.md                       # L2: Automation guide
  scripts/                        # Automation scripts
    weekly_review.py
    content_ideas.py
    stale_contacts.py

examples/                         # Workflow walkthrough docs
references/
  file-formats.md                 # Complete schema specs for all data files
```

## Token efficiency

- Simple task query: L1 + L2 only ~ 150 tokens
- Full data scan: only when explicitly needed
- Without this system: 5,000+ tokens to load everything at once
