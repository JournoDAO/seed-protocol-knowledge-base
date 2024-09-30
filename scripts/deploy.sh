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

git clone https://$GITHUB_PERSONAL_ACCESS_TOKEN@github.com/$REPO_OWNER/$REPO_NAME.git $TARGET_DIR
