#!/bin/sh
# Build Cosmic using Maven wrapper
set -e

if [ ! -x ./mvnw ]; then
    echo "Maven wrapper not found" >&2
    exit 1
fi

./mvnw -DskipTests package
