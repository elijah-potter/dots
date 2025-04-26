#!/bin/bash

# Define the URL for the latest release
URL="https://api.github.com/repos/automattic/harper-obsidian-plugin/releases/latest"

# Fetch release data silently
DATA=$(curl -sL "$URL" -H "Accept: application/vnd.github.v3+json")

# Use jq to sum the download_count for all assets
TOTAL=$(echo "$DATA" | jq '[.assets[].download_count] | add')
echo $(($TOTAL / 2))
