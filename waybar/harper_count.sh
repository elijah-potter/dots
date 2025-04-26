#!/bin/bash

# Define the URL for the latest release
URL="https://api.github.com/repos/chilipepperhott/harper/releases/latest"

# Fetch release data silently
DATA=$(curl -sL "$URL" -H "Accept: application/vnd.github.v3+json")

# Sum download_count for all assets except harper.zip
TOTAL=$(echo "$DATA" | jq '[.assets[] | select(.name != "harper.zip") | .download_count] | add')
echo "$TOTAL"
