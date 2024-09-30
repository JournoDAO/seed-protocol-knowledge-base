#!/bin/bash

# Exit script if any command fails
set -e

echo "Syncing files from $SOURCE_DIR to $TARGET_DIR..."

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

# Remove the target directory if it already exists
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

cp -r $SOURCE_DIR $TARGET_DIR

chokidar "$SOURCE_DIR**/*" -c "rsync -av --delete $SOURCE_DIR $TARGET_DIR"

echo "Files synced successfully from $SOURCE_DIR to $TARGET_DIR."
