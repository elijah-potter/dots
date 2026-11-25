#!/usr/bin/env bash
# Link portable Pi resources without overwriting local files. Existing correct links are kept.
set -euo pipefail

source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
agent_dir="$HOME/.pi/agent"

# Check all destinations before changing any links.
for name in APPEND_SYSTEM.md extensions prompts; do
    source_path="$source_dir/$name"
    target_path="$agent_dir/$name"
    if [[ ! -e "$source_path" ]]; then
        printf 'Missing source: %s\n' "$source_path" >&2
        exit 1
    fi
    if [[ -L "$target_path" ]] && [[ $(readlink -f -- "$target_path") == "$source_path" ]]; then
        continue
    fi
    # Replace the previous link created before APPEND_SYSTEM.md moved into pi/.
    if [[ "$name" == APPEND_SYSTEM.md && -L "$target_path" ]] &&
        [[ $(readlink -- "$target_path") == "$HOME/.config/APPEND_SYSTEM.md" ]]; then
        continue
    fi
    if [[ -e "$target_path" || -L "$target_path" ]]; then
        printf 'Destination already exists: %s\n' "$target_path" >&2
        exit 1
    fi
done

mkdir -p -- "$agent_dir"
for name in APPEND_SYSTEM.md extensions prompts; do
    source_path="$source_dir/$name"
    target_path="$agent_dir/$name"
    if [[ -L "$target_path" ]] && [[ $(readlink -f -- "$target_path") == "$source_path" ]]; then
        continue
    fi
    if [[ -L "$target_path" ]]; then
        rm -- "$target_path"
    fi
    ln -s -- "$source_path" "$target_path"
done
