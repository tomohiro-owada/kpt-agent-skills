#!/bin/bash
# KPT Hooks Installer
# Installs the hook script and /kpt skill into ~/.claude/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "=== KPT Hooks Installer ==="
echo ""

# 1. Install hook script
echo "[1/3] Installing hook script..."
mkdir -p "${CLAUDE_DIR}/hooks"
cp "${SCRIPT_DIR}/hooks/on-stop.sh" "${CLAUDE_DIR}/hooks/on-stop.sh"
chmod +x "${CLAUDE_DIR}/hooks/on-stop.sh"
echo "  -> ${CLAUDE_DIR}/hooks/on-stop.sh"

# 2. Install /kpt skill
echo "[2/4] Installing skills..."
for skill in kpt kpt-report kpt-trends; do
  mkdir -p "${CLAUDE_DIR}/skills/${skill}"
  cp "${SCRIPT_DIR}/skills/${skill}/SKILL.md" "${CLAUDE_DIR}/skills/${skill}/SKILL.md"
  echo "  -> ${CLAUDE_DIR}/skills/${skill}/SKILL.md"
done

# 3. Create log directories
echo "[3/4] Creating log directories..."
mkdir -p "${CLAUDE_DIR}/kpt-logs/retrospectives" "${CLAUDE_DIR}/kpt-logs/reports"
echo "  -> ${CLAUDE_DIR}/kpt-logs/"

echo ""
echo "[4/4] Done!"
echo ""
echo "=== Installation complete! ==="
echo ""
echo "Next step: Add the Stop hook to your Claude Code settings."
echo ""
echo "Add the following to ~/.claude/settings.json:"
echo ""
cat << 'SETTINGS'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/on-stop.sh"
          }
        ]
      }
    ]
  }
}
SETTINGS
echo ""
echo "Or run this command to open the settings file:"
echo "  claude /update-config"
echo ""
echo "Usage:"
echo "  /kpt today                     - KPT retrospective (today)"
echo "  /kpt week                      - KPT retrospective (last 7 days)"
echo "  /kpt 2026-03-15..2026-03-20   - KPT retrospective (date range)"
echo "  /kpt-report week               - Activity report (last 7 days)"
echo "  /kpt-report month              - Activity report (last 30 days)"
echo "  /kpt-trends                    - Trend analysis across past KPTs"
