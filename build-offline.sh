#!/bin/sh
set -e
# Build the server jar in offline mode using the Maven wrapper
# Requires a prior online build to populate the Maven cache
DIR="$(dirname "$0")"
cd "$DIR" || exit 1
./mvnw -o -DskipTests package
