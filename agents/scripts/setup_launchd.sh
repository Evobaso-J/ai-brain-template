#!/bin/bash
# Sets up the daily sync launchd agent for this machine.
# Run once after cloning: bash agents/scripts/setup_launchd.sh

REPO="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPT="$REPO/agents/scripts/daily_sync.sh"
LOG="$REPO/agents/scripts/daily_sync.log"
PLIST="$HOME/Library/LaunchAgents/com.ai-brain.daily-sync.plist"

chmod +x "$SCRIPT"

cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.ai-brain.daily-sync</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$SCRIPT</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>23</integer>
    <key>Minute</key>
    <integer>0</integer>
  </dict>
  <key>StandardOutPath</key>
  <string>$LOG</string>
  <key>StandardErrorPath</key>
  <string>$LOG</string>
</dict>
</plist>
EOF

launchctl load "$PLIST"
echo "Loaded: $PLIST"
echo "Repo:   $REPO"
echo "Runs daily at 23:00. To test now: launchctl start com.ai-brain.daily-sync"
