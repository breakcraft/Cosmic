#!/bin/sh
set -e
# Run the full Maven test suite
# Pass -o to run offline if dependencies are cached
./mvnw test
