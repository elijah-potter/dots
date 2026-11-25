#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.pi/agent"
ln -sfnT "$HOME/.config/pi/APPEND_SYSTEM.md" "$HOME/.pi/agent/APPEND_SYSTEM.md"
ln -sfnT "$HOME/.config/pi/extensions" "$HOME/.pi/agent/extensions"
ln -sfnT "$HOME/.config/pi/prompts" "$HOME/.pi/agent/prompts"
