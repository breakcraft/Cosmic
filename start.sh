#!/bin/sh
# Simple helper script to build and run the server
set -e
DIR="$(dirname "$0")"
cd "$DIR" || exit 1

if [ ! -f target/Cosmic.jar ]; then
    echo "Building Cosmic..."
    ./mvnw -DskipTests package
fi

echo "Launching Cosmic..."
java -jar target/Cosmic.jar "$@"
