#!/usr/bin/env python3
"""
Stale Contacts Finder

Identifies contacts overdue for outreach based on circle tier and last_contact date.

Thresholds:
  inner   → 14 days
  active  → 42 days (6 weeks)
  network → 120 days (4 months)
  dormant → skipped

Usage: python agents/scripts/stale_contacts.py
"""

import json
import os
from datetime import datetime, timedelta

BRAIN_ROOT = os.path.join(os.path.dirname(__file__), "../..")

THRESHOLDS = {
    "inner": 14,
    "active": 42,
    "network": 120,
}


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


def days_since(date_str: str) -> int:
    if not date_str:
        return 999
    try:
        then = datetime.strptime(date_str, "%Y-%m-%d").date()
        return (datetime.now().date() - then).days
    except ValueError:
        return 999


def main():
    contacts = load_jsonl(os.path.join(BRAIN_ROOT, "network/contacts.jsonl"))

    # Deduplicate: keep latest entry per name
    seen: dict[str, dict] = {}
    for c in contacts:
        seen[c["name"]] = c
    unique = list(seen.values())

    stale: dict[str, list] = {"inner": [], "active": [], "network": []}

    for c in unique:
        circle = c.get("circle", "")
        if circle not in THRESHOLDS:
            continue
        threshold = THRESHOLDS[circle]
        age = days_since(c.get("last_contact", ""))
        if age >= threshold:
            stale[circle].append((age, c))

    print("\n=== Stale Contacts Report ===\n")

    total = 0
    for circle in ("inner", "active", "network"):
        entries = sorted(stale[circle], key=lambda x: x[0], reverse=True)
        if entries:
            print(f"## {circle.capitalize()} (threshold: {THRESHOLDS[circle]} days)\n")
            for age, c in entries:
                last = c.get("last_contact") or "never"
                print(f"- {c['name']} ({c.get('role', '?')} @ {c.get('company', '?')}) — {age}d ago [{last}]")
                if c.get("notes"):
                    print(f"  {c['notes'][:80]}")
            print()
            total += len(entries)

    if total == 0:
        print("All contacts are up to date.\n")
    else:
        print(f"=== {total} contacts need outreach ===\n")
        print("Next: log interactions in network/interactions.jsonl after reaching out")


if __name__ == "__main__":
    main()
