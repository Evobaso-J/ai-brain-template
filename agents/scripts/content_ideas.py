#!/usr/bin/env python3
"""
Content Ideas Generator

Surfaces potential content ideas by cross-referencing:
- knowledge/bookmarks.jsonl (unread/read bookmarks not yet turned into content)
- knowledge/notes/ (quick captures)
- content/ideas.jsonl (existing ideas in raw state)

Usage: python agents/scripts/content_ideas.py
"""

import json
import os
from pathlib import Path

BRAIN_ROOT = os.path.join(os.path.dirname(__file__), "../..")


def load_jsonl(path: str) -> list[dict]:
    entries = []
    try:
        with open(path) as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('{"_schema"'):
                    entries.append(json.loads(line))
    except FileNotFoundError:
        pass
    return entries


def main():
    print("\n=== Content Ideas Report ===\n")

    # Existing raw ideas
    ideas = load_jsonl(os.path.join(BRAIN_ROOT, "content/ideas.jsonl"))
    raw_ideas = [i for i in ideas if i.get("status") in ("raw", "developing")]
    if raw_ideas:
        print(f"## {len(raw_ideas)} Existing Ideas (raw/developing)\n")
        for idea in sorted(raw_ideas, key=lambda x: x.get("priority", "P3")):
            print(f"- [{idea.get('priority', '?')}] [{idea.get('format', '?')}] {idea['title']}")
            if idea.get("notes"):
                print(f"  → {idea['notes'][:100]}")
        print()

    # High-rated unused bookmarks
    bookmarks = load_jsonl(os.path.join(BRAIN_ROOT, "knowledge/bookmarks.jsonl"))
    unused = [b for b in bookmarks if b.get("status") in ("read", "reviewed") and b.get("rating", 0) >= 4]
    if unused:
        print(f"## {len(unused)} High-Value Bookmarks Not Yet Used as Content\n")
        for b in unused[:10]:  # top 10
            print(f"- [{b.get('category', '?')}] {b['title']}")
            print(f"  Why saved: {b.get('why_saved', '')[:100]}")
            print(f"  → {b.get('url', '')}")
        print()

    # Notes directory
    notes_dir = Path(BRAIN_ROOT) / "knowledge" / "notes"
    if notes_dir.exists():
        notes = list(notes_dir.glob("*.md"))
        if notes:
            print(f"## {len(notes)} Quick-Capture Notes\n")
            for note in sorted(notes, key=lambda x: x.stat().st_mtime, reverse=True)[:5]:
                print(f"- {note.name}")
            print()

    print("=== End of Report ===\n")
    print("Next: append promising ideas to content/ideas.jsonl")


if __name__ == "__main__":
    main()
