#!/bin/sh
# Run the full Maven test suite. If dependency resolution fails,
# automatically retry in offline mode.
./mvnw test || ./mvnw -o test
