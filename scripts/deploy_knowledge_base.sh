#!/bin/bash

# Exit script if any command fails
set -e

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

echo "Pulling the latest content from the remote repository..."

git pull

npx quartz build --serve

echo "Content pulled successfully from the remote repository."
