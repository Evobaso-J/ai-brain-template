# Example: Content Creation Workflow

A walkthrough of creating a technical Twitter/X thread about a topic you've been researching.

---

## Scenario

You want to write a thread about a pattern you discovered while working on a project.

## Step 1: Check if the idea already exists

```
Read content/ideas.jsonl → filter by title keyword
```

If it exists, update its status. If not, append a new entry:

```json
{"id": "idea_20260401_090000", "title": "Why append-only logs beat mutable state for audit trails", "format": "thread", "pillar": "architecture", "status": "raw", "priority": "P1", "source": "engineering/projects", "notes": "Learned this building X — concrete examples", "created": "2026-04-01", "updated": "2026-04-01"}
```

## Step 2: Research support

```
Read knowledge/bookmarks.jsonl → filter by tags: ["architecture", "event-sourcing"]
```

Pull 2–3 supporting references. Note their IDs for the draft.

## Step 3: Read voice.md

```
Read identity/voice.md
```

Check tone, vocabulary, and thread format template. Match energy level and avoid prohibited phrases.

## Step 4: Draft using the template

```
Read content/templates/thread.md
```

Create `content/drafts/2026-04-01-append-only-logs.md` and fill in the template.

## Step 5: Voice check

Before finalizing: does this sound like you? Check against:
- Sentence structure from voice.md
- Brand pillar alignment from brand.md
- No vocabulary anti-patterns

## Step 6: Publish and archive

After posting, append to `content/posts.jsonl`:

```json
{"id": "post_20260401_140000", "title": "Why append-only logs beat mutable state", "format": "thread", "platform": "twitter", "url": "https://twitter.com/...", "published": "2026-04-01", "impressions": 0, "engagement": 0, "notes": "", "pillar": "architecture"}
```

Update the idea status to `published`.

---

**Token cost for this workflow:** ~450 tokens (identity/voice.md + 2 bookmark entries + templates/thread.md)
