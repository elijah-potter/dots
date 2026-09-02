#!/usr/bin/env bash
set -euo pipefail

repo="automattic/harper"

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/gh-rofi"
mkdir -p "$cache_dir"

repo_key="${repo//\//__}"
json_cache="$cache_dir/${repo_key}-issues.json"
lock_dir="$cache_dir/${repo_key}-issues.lock"

refresh_issues() {
  local tmp
  tmp="$(mktemp)"
  gh issue list --repo "$repo" --limit 2000 --state all --json number,title,state,url > "$tmp" && mv "$tmp" "$json_cache" || rm -f "$tmp"
}

if mkdir "$lock_dir" 2>/dev/null; then
  (
    refresh_issues
    rmdir "$lock_dir"
  ) >/dev/null 2>&1 &
fi

if [ ! -s "$json_cache" ]; then
  refresh_issues
fi

selection="$(
  jq -r '.[] | "#\(.number) [\(.state)] \(.title)\t\(.url)"' "$json_cache" \
  | rofi -dmenu -i -p "Issues $repo"
)"

url="$(printf '%s\n' "$selection" | awk -F '\t' '{print $2}')"
[ -n "$url" ] && xdg-open "$url"
