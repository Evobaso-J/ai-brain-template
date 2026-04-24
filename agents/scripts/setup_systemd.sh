#!/bin/bash
# Installs systemd user unit for auto git sync file watcher (Linux).
# Run once after cloning: bash agents/scripts/setup_systemd.sh

REPO="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPTS="$REPO/agents/scripts"
UNIT_DIR="$HOME/.config/systemd/user"

chmod +x "$SCRIPTS/watch_and_push.sh"
mkdir -p "$UNIT_DIR"

# Clean up legacy cron-style units from earlier setup
for legacy in ai-brain-daily-sync.timer ai-brain-daily-sync.service ai-brain-periodic-pull.timer ai-brain-periodic-pull.service; do
  systemctl --user disable --now "$legacy" 2>/dev/null
  rm -f "$UNIT_DIR/$legacy"
done

cat > "$UNIT_DIR/ai-brain-watch-and-push.service" <<EOF
[Unit]
Description=AI Brain file watcher (auto pull + push on edit)

[Service]
Type=simple
ExecStart=/bin/bash $SCRIPTS/watch_and_push.sh
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now ai-brain-watch-and-push.service

echo ""
echo "Repo: $REPO"
echo "Unit: watch-and-push (pull + push on every edit, 30s debounce)"
echo "Check: systemctl --user status ai-brain-watch-and-push"
