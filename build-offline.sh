#!/bin/sh
# Build the server jar in offline mode using the Maven wrapper
DIR="$(dirname "$0")"
cd "$DIR" || exit 1
./mvnw -o -DskipTests package
