#!/usr/bin/env bash
# agentnotify — send OTP/authorization challenges via ntfy
# Usage: notify.sh <topic> <message> [title] [priority]
# Env: NTFY_SERVER (default: https://ntfy.sh), NTFY_TOKEN (optional)

set -euo pipefail
TOPIC="${1:?Topic required}"
MESSAGE="${2:?Message required}"
TITLE="${3:-Authorization}"
PRIORITY="${4:-default}"
SERVER="${NTFY_SERVER:-https://ntfy.sh}"
URL="${SERVER}/${TOPIC}"

JSON=$(jq -n \
  --arg title "$TITLE" \
  --arg message "$MESSAGE" \
  --arg priority "$PRIORITY" \
  --arg topic "$TOPIC" \
  '{topic: $topic, title: $title, message: $message, priority: $priority}')

if [[ -n "${NTFY_TOKEN:-}" ]]; then
  curl -s -X POST -H "Authorization: Bearer $NTFY_TOKEN" -H "Content-Type: application/json" -d "$JSON" "$URL"
else
  curl -s -X POST -H "Content-Type: application/json" -d "$JSON" "$URL"
fi

echo "Sent: $MESSAGE → $TOPIC" >&2
