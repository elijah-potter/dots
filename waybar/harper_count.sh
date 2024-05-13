#! /bin/bash

URL="https://api.github.com/repos/chilipepperhott/harper/releases?per_page=100"

DATA=`curl -L "$URL" -H "Accept: application/vnd.github.v3+json"`

# Below prints total for all binaries for all rleases.
echo $DATA | jq '.[].assets[].download_count' | awk '{s+=$1} END {print s}'
