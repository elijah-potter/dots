#! /bin/bash

URL="https://api.github.com/repos/elijah-potter/harper-obsidian-plugin/releases?per_page=100"

DATA=`curl -L "$URL" -H "Accept: application/vnd.github.v3+json"`

# Below prints total for all binaries for all rleases.
COUNT=$(echo $DATA | jq '.[].assets[].download_count' | awk '{s+=$1} END {print s}')

echo $(($COUNT / 2))
