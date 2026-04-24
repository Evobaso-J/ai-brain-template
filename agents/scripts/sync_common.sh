#!/bin/bash
# Shared sync functions — sourced by all sync scripts.
# Do not execute directly.

SYNC_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SYNC_LOG="$SYNC_REPO/agents/scripts/sync.log"
SYNC_LOCK="/tmp/ai-brain-sync.lock"

sync_log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') — $1" >> "$SYNC_LOG"
}

sync_acquire_lock() {
  if ! mkdir "$SYNC_LOCK" 2>/dev/null; then
    sync_log "SKIP: another sync is running"
    return 1
  fi
  trap 'rmdir "$SYNC_LOCK" 2>/dev/null' EXIT
  return 0
}

sync_pull() {
  cd "$SYNC_REPO" || return 1
  if git pull --rebase --autostash origin main >> "$SYNC_LOG" 2>&1; then
    sync_log "pull: ok"
  else
    git rebase --abort 2>/dev/null
    sync_log "pull: CONFLICT — rebase aborted, local commits preserved"
    return 1
  fi
}

sync_push() {
  local msg="${1:-sync: auto $(date '+%Y-%m-%d %H:%M')}"
  cd "$SYNC_REPO" || return 1

  # Pull first
  sync_pull

  # Stage everything
  git add -A

  # Skip if nothing to commit
  if git diff --cached --quiet 2>/dev/null; then
    sync_log "push: nothing to commit"
    return 0
  fi

  git commit -m "$msg" >> "$SYNC_LOG" 2>&1
  if git push origin main >> "$SYNC_LOG" 2>&1; then
    sync_log "push: ok"
  else
    sync_log "push: FAILED"
    return 1
  fi
}
