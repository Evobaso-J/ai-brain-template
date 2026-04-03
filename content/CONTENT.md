# Content Module

Hub for all content creation: blog posts, technical threads, conference talks, open source docs.

## Files

| File | Purpose |
|------|---------|
| `ideas.jsonl` | Raw content ideas — append here first |
| `posts.jsonl` | Published content archive with engagement data |
| `engagement.jsonl` | Inspiring / reference content from others |
| `calendar.md` | Content schedule and upcoming deadlines |
| `drafts/` | Work-in-progress pieces |
| `templates/` | Reusable formats (blog-post, technical-post, thread, talk-proposal) |

## Schema

**ideas.jsonl**
```json
{"id": "idea_YYYYMMDD_HHMMSS", "title": "...", "format": "thread|post|talk|oss-doc|newsletter", "pillar": "...", "status": "raw|developing|ready|published|archived", "priority": "P0|P1|P2|P3", "source": "...", "notes": "...", "created": "YYYY-MM-DD", "updated": "YYYY-MM-DD"}
```

**posts.jsonl**
```json
{"id": "post_YYYYMMDD_HHMMSS", "title": "...", "format": "thread|post|talk|oss-doc|newsletter", "platform": "twitter|linkedin|blog|github|conference", "url": "...", "published": "YYYY-MM-DD", "impressions": 0, "engagement": 0, "notes": "...", "pillar": "..."}
```

**engagement.jsonl**
```json
{"id": "eng_YYYYMMDD_HHMMSS", "url": "...", "title": "...", "author": "...", "why_saved": "...", "saved": "YYYY-MM-DD"}
```

## Workflow

**Capture an idea:**
1. Check `ideas.jsonl` for existing similar idea
2. Append with `status: raw` and a priority
3. Add notes: what angle, what's the hook

**Draft content:**
1. Read `identity/voice.md` — match tone and style
2. Validate against `identity/brand.md` — does this fit a content pillar?
3. Check `content/templates/` for the right format
4. Save draft to `drafts/` as `YYYY-MM-DD-slug.md`
5. Update idea entry status to `developing`

**Publish:**
1. Update idea status to `published`
2. Append to `posts.jsonl` with URL and platform
3. Archive draft or delete after confirmed publish

**Find what to create next:**
1. Read `ideas.jsonl` — filter `status: raw|developing`, sort by priority
2. Check `calendar.md` for upcoming deadlines
3. Cross-reference with `knowledge/bookmarks.jsonl` for relevant research

## Instructions

<instructions>
- ALWAYS read identity/voice.md before writing any content.
- Append to ideas.jsonl rather than overwriting — history is valuable for pattern analysis.
- Never publish without a voice check — validate tone before finalizing.
- Format values: thread / post / talk / oss-doc / newsletter
- Priority follows P0–P3 from AGENT.md.
- drafts/ filenames: YYYY-MM-DD-kebab-title.md
</instructions>
