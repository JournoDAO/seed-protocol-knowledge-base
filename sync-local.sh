#!/bin/bash

# Exit script if any command fails
set -e

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

# Remove the target directory if it already exists
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

cp -r $SOURCE_DIR $TARGET_DIR

chokidar "$SOURCE_DIR**/*" -c "rsync -av --delete --exclude '.idea' --exclude '.git' --exclude '.DS_Store' --exclude '.gitignore' --exclude '.github' $SOURCE_DIR $TARGET_DIR && npx quartz build"

echo "Files synced successfully from $SOURCE_DIR to $TARGET_DIR."
