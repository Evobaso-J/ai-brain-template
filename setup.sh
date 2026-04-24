#!/bin/bash
# Run once after cloning: bash setup.sh
# Installs Claude Code (if needed), configures global context, and sets up daily sync.
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"

# 1. Install Claude Code if not present
if ! command -v claude &> /dev/null; then
  echo "==> Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
  if ! command -v claude &> /dev/null; then
    echo "ERROR: Claude Code installation failed" >&2
    exit 1
  fi
else
  echo "==> Claude Code already installed: $(claude --version)"
fi

# 2. Generate ~/.claude/CLAUDE.md from template
mkdir -p ~/.claude
if [ -f ~/.claude/CLAUDE.md ] && [ ! -f ~/.claude/CLAUDE.md.bak ]; then
  cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.bak
  echo "==> Backed up existing ~/.claude/CLAUDE.md"
fi
sed "s|{{REPO}}|$REPO|g" "$REPO/agents/templates/claude-global.md" > ~/.claude/CLAUDE.md
echo "==> Configured ~/.claude/CLAUDE.md"

# 3. Merge permissions into ~/.claude/settings.json
python3 "$REPO/agents/scripts/merge_settings.py" "$REPO"
echo "==> Configured ~/.claude/settings.json"

# 4. Install file watcher for auto-push
case "$(uname)" in
  Darwin)
    if ! command -v fswatch &>/dev/null; then
      if command -v brew &>/dev/null; then
        echo "==> Installing fswatch..."
        brew install fswatch
      else
        echo "==> WARN: brew not found, skipping fswatch install (auto-push on edit won't work)"
      fi
    else
      echo "==> fswatch already installed"
    fi
    ;;
  Linux)
    if ! command -v inotifywait &>/dev/null; then
      if command -v apt &>/dev/null; then
        echo "==> Installing inotify-tools..."
        sudo apt install -y inotify-tools
      elif command -v dnf &>/dev/null; then
        echo "==> Installing inotify-tools..."
        sudo dnf install -y inotify-tools
      else
        echo "==> WARN: could not install inotify-tools (auto-push on edit won't work)"
      fi
    else
      echo "==> inotifywait already installed"
    fi
    ;;
esac

# 5. Set up sync services (auto-pull + auto-push)
case "$(uname)" in
  Darwin)
    bash "$REPO/agents/scripts/setup_launchd.sh"
    echo "==> Sync services configured (launchd)"
    ;;
  Linux)
    bash "$REPO/agents/scripts/setup_systemd.sh"
    echo "==> Sync services configured (systemd)"
    ;;
  *)
    echo "==> WARN: unsupported platform, sync not configured"
    ;;
esac

echo "==> Done. ai-brain is now available in all Claude sessions."
