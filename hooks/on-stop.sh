#!/bin/bash
# KPT Activity Logger - Claude Code Stop Hook
# Runs after every Claude response, saves activity to JSONL

set -euo pipefail

KPT_LOG_DIR="${HOME}/.claude/kpt-logs"
YEAR_MONTH=$(date +"%Y-%m")
KPT_LOG_FILE="${KPT_LOG_DIR}/activity_${YEAR_MONTH}.jsonl"

mkdir -p "${KPT_LOG_DIR}"

# Read hook input from stdin
INPUT=$(cat)

# Extract fields from hook input
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "unknown"')

# Extract the last assistant message (truncate to 500 chars to keep logs manageable)
ASSISTANT_MSG=$(echo "$INPUT" | jq -r '.last_assistant_message // ""' | head -c 500)

# Skip empty messages
if [ -z "$ASSISTANT_MSG" ]; then
  exit 0
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOCAL_DATE=$(date +"%Y-%m-%d")
LOCAL_TIME=$(date +"%H:%M:%S")
PROJECT=$(basename "$CWD")

# Build JSON entry and append to log
jq -n \
  --arg ts "$TIMESTAMP" \
  --arg date "$LOCAL_DATE" \
  --arg time "$LOCAL_TIME" \
  --arg sid "$SESSION_ID" \
  --arg cwd "$CWD" \
  --arg project "$PROJECT" \
  --arg msg "$ASSISTANT_MSG" \
  '{timestamp: $ts, local_date: $date, local_time: $time, session_id: $sid, cwd: $cwd, project: $project, message: $msg}' \
  >> "${KPT_LOG_FILE}"

exit 0
