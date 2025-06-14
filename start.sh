#!/bin/sh
# Simple helper script to build and run the server
set -e
DIR="$(dirname "$0")"
cd "$DIR" || exit 1

if ! command -v java >/dev/null 2>&1; then
    echo "Java must be installed" >&2
    exit 1
fi

if [ ! -f target/Cosmic.jar ]; then
    echo "Building Cosmic..."
    ./mvnw -DskipTests package
fi

echo "Launching Cosmic..."
java -jar target/Cosmic.jar "$@"
