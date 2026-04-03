#!/usr/bin/env python3
"""
Weekly Review Generator

Reads data from operations/, content/, network/, and engineering/ modules
and generates a structured weekly review summary.

Usage: python agents/scripts/weekly_review.py
"""

import json
import os
from datetime import datetime, timedelta

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


def week_range() -> tuple[str, str]:
    today = datetime.now().date()
    start = today - timedelta(days=today.weekday())
    end = start + timedelta(days=6)
    return start.isoformat(), end.isoformat()


def main():
    week_start, week_end = week_range()
    print(f"\n=== Weekly Review: {week_start} → {week_end} ===\n")

    # Open tasks
    todos_path = os.path.join(BRAIN_ROOT, "operations/todos.md")
    if os.path.exists(todos_path):
        with open(todos_path) as f:
            print("## Open Tasks\n")
            print(f.read())

    # Recent decisions
    decisions = load_jsonl(os.path.join(BRAIN_ROOT, "operations/decisions.jsonl"))
    recent = [d for d in decisions if d.get("date", "") >= week_start]
    if recent:
        print("## Decisions This Week\n")
        for d in recent:
            print(f"- [{d.get('outcome', '?')}] {d['title']}: {d['decision']}")
        print()

    # Published content
    posts = load_jsonl(os.path.join(BRAIN_ROOT, "content/posts.jsonl"))
    recent_posts = [p for p in posts if p.get("published", "") >= week_start]
    if recent_posts:
        print("## Content Published\n")
        for p in recent_posts:
            print(f"- [{p.get('platform')}] {p['title']}")
        print()

    # Interactions
    interactions = load_jsonl(os.path.join(BRAIN_ROOT, "network/interactions.jsonl"))
    recent_ix = [i for i in interactions if i.get("date", "") >= week_start]
    if recent_ix:
        print("## Interactions This Week\n")
        for i in recent_ix:
            print(f"- {i.get('date')} | {i.get('contact_name')} [{i.get('type')}]: {i.get('summary', '')[:80]}")
        print()

    # Active projects
    projects = load_jsonl(os.path.join(BRAIN_ROOT, "engineering/projects.jsonl"))
    active = [p for p in projects if p.get("status") == "active"]
    if active:
        print("## Active Projects\n")
        for p in active:
            print(f"- {p['name']} ({', '.join(p.get('stack', []))}): {p.get('notes', '')[:80]}")
        print()

    print("=== End of Review ===\n")
    print("Next: append metrics to operations/metrics.jsonl and save review to operations/reviews/")


if __name__ == "__main__":
    main()
