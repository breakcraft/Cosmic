#!/bin/sh
# Run project tests using Maven wrapper
DIR="$(dirname "$0")/../.."
cd "$DIR" || exit 1
./mvnw test

