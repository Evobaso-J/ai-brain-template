#!/bin/bash
# Installs launchd file watcher for auto git sync (macOS).
# Run once after cloning: bash agents/scripts/setup_launchd.sh

REPO="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPTS="$REPO/agents/scripts"
LOG="$SCRIPTS/sync.log"

chmod +x "$SCRIPTS/watch_and_push.sh"

CURRENT_PATH="$PATH"

# Clean up any legacy cron-style agents from earlier setup
for legacy in com.ai-brain.daily-sync com.ai-brain.periodic-pull; do
  launchctl unload "$HOME/Library/LaunchAgents/${legacy}.plist" 2>/dev/null
  rm -f "$HOME/Library/LaunchAgents/${legacy}.plist"
done

install_plist() {
  local label="$1" plist_content="$2"
  local plist_path="$HOME/Library/LaunchAgents/${label}.plist"
  launchctl unload "$plist_path" 2>/dev/null
  echo "$plist_content" > "$plist_path"
  launchctl load "$plist_path"
  echo "Loaded: $label"
}

install_plist "com.ai-brain.watch-and-push" "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
  <key>Label</key>
  <string>com.ai-brain.watch-and-push</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key>
    <string>$CURRENT_PATH</string>
  </dict>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$SCRIPTS/watch_and_push.sh</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>ThrottleInterval</key>
  <integer>10</integer>
  <key>StandardOutPath</key>
  <string>$LOG</string>
  <key>StandardErrorPath</key>
  <string>$LOG</string>
</dict>
</plist>"

echo ""
echo "Repo:  $REPO"
echo "Agent: watch-and-push (pull + push on every edit, 30s debounce)"
echo "Log:   $LOG"
