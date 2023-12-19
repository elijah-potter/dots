#!/bin/bash
#
SELECTED=$(find ~/.config/wallpapers -type f -name "*.jpg" | shuf -n 1)

swaybg -m fill -i $(realpath $SELECTED)
