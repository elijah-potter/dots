#!/usr/bin/env bash
set -euo pipefail

cd /home/elijahpotter/.config/wallpapers

SELECTED=$(find . -maxdepth 1 -type f -name "*.jpg" ! -name "output.jpg" | shuf -n 1)
OUTPUT="./output.jpg"
FONT="./Domine.ttf"
HERO_TEXT_FILE="./hero_text.txt"
HERO_TEXT=$(<"$HERO_TEXT_FILE")

magick "$SELECTED" \
  -gravity center \
  -font "$FONT" \
  -pointsize 128 \
  -fill white \
  -annotate +0+0 "$HERO_TEXT" \
  "$OUTPUT"

swaybg -m fill -i "$OUTPUT"
