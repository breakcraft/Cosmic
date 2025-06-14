#!/bin/sh
# Build using the local Maven repository only
DIR=$(dirname "$0")/..
cd "$DIR" || exit 1
./mvnw -o package

