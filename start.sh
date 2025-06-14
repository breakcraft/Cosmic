#!/bin/sh
set -e
# Simple helper script to build and run the server
DIR="$(dirname "$0")"

if [ ! -f "$DIR/target/Cosmic.jar" ]; then
    "$DIR/mvnw" -DskipTests package || exit 1
fi

exec java -jar "$DIR/target/Cosmic.jar" "$@"
