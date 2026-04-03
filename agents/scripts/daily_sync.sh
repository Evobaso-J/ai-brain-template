#!/bin/bash
REPO="$(cd "$(dirname "$0")/../.." && pwd)"
LOG="$REPO/agents/scripts/daily_sync.log"
cd "$REPO" || exit 1

# Only commit if there are changes
if [[ -z "$(git status --porcelain)" ]]; then
  echo "$(date '+%Y-%m-%d %H:%M') — no changes, skipping" >> "$LOG"
  exit 0
fi

git add -A
git commit -m "chore: daily sync $(date '+%Y-%m-%d')"
git push origin main >> "$LOG" 2>&1
echo "$(date '+%Y-%m-%d %H:%M') — synced" >> "$LOG"
