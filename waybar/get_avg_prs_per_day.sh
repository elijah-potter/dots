#!/usr/bin/env bash

USER="elijah-potter"
DAYS=14

if date -v -1d +%F >/dev/null 2>&1; then
  END_DATE=$(date +%F)
  START_DATE=$(date -v -"${DAYS}"d +%F)
else
  END_DATE=$(date +%F)
  START_DATE=$(date -d "${DAYS} days ago" +%F)
fi

QUERY="is:pr+author:${USER}+created:${START_DATE}..${END_DATE}"
API_URL="https://api.github.com/search/issues?q=${QUERY}"

RESP=$(curl -s -H "Accept: application/vnd.github+json" "$API_URL")
TOTAL=$(printf '%s' "$RESP" | jq '.total_count // -1')

if [ "$TOTAL" -lt 0 ]; then
  printf '%s\n' "$RESP" >&2
  exit 1
fi

awk -v t="$TOTAL" -v d="$DAYS" 'BEGIN { printf "%.4f\n", t/d }'
