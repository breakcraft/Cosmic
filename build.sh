#!/bin/sh
set -e
# Build Cosmic using Maven wrapper
# Use build-offline.sh for network-restricted environments
./mvnw -DskipTests package
