#!/bin/sh
set -e
# Display current git branch (useful inside containers)
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $branch"
