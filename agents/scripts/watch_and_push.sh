#!/bin/bash
# Watches for file changes and auto-commits + pushes with 30s debounce.
# Requires: fswatch (macOS) or inotifywait (Linux).
source "$(dirname "$0")/sync_common.sh"

DEBOUNCE_SEC=30

do_sync() {
  if sync_acquire_lock; then
    sync_push
    rmdir "$SYNC_LOCK" 2>/dev/null
    trap - EXIT
  fi
}

cd "$SYNC_REPO" || exit 1

if command -v fswatch &>/dev/null; then
  # macOS: fswatch with built-in latency debounce
  fswatch -r -l "$DEBOUNCE_SEC" \
    --exclude '\.git' \
    --exclude 'sync\.log' \
    --exclude 'daily_sync\.log' \
    "$SYNC_REPO" | while read -r _; do
      # Drain buffered events
      while read -r -t 1 _; do :; done
      do_sync
    done

elif command -v inotifywait &>/dev/null; then
  # Linux: inotifywait with manual debounce
  while true; do
    inotifywait -r -q -q \
      --exclude '(\.git|sync\.log|daily_sync\.log)' \
      -e modify -e create -e delete -e move \
      "$SYNC_REPO"
    sleep "$DEBOUNCE_SEC"
    do_sync
  done

else
  echo "ERROR: neither fswatch nor inotifywait found." >&2
  echo "Install: brew install fswatch (macOS) or apt install inotify-tools (Linux)" >&2
  exit 1
fi
