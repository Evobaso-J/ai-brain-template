#!/usr/bin/env python3
"""Merge ai-brain permissions into ~/.claude/settings.json without clobbering existing config."""

import json
import os
import sys
import tempfile
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Usage: merge_settings.py <repo-path>", file=sys.stderr)
        sys.exit(1)

    repo = sys.argv[1]
    settings_path = Path.home() / ".claude" / "settings.json"

    # Load existing settings or start fresh
    if settings_path.exists():
        settings = json.loads(settings_path.read_text())
    else:
        settings = {}

    # Ensure permissions structure exists
    permissions = settings.setdefault("permissions", {})
    allow = permissions.setdefault("allow", [])
    additional_dirs = permissions.setdefault("additionalDirectories", [])

    # Required permission entries
    required_perms = [
        f"Read({repo}/**)",
        f"Edit({repo}/**)",
        f"Write({repo}/**)",
    ]

    for perm in required_perms:
        if perm not in allow:
            allow.append(perm)

    if repo not in additional_dirs:
        additional_dirs.append(repo)

    tmp_path = settings_path.with_suffix(".tmp")
    tmp_path.write_text(json.dumps(settings, indent=2) + "\n")
    os.replace(tmp_path, settings_path)


if __name__ == "__main__":
    main()
