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

# 4. Set up daily sync (macOS only)
if [ "$(uname)" = "Darwin" ]; then
  bash "$REPO/agents/scripts/setup_launchd.sh"
  echo "==> Daily sync configured"
fi

echo "==> Done. ai-brain is now available in all Claude sessions."
