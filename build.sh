#!/bin/sh
set -e
# Build Cosmic using Maven wrapper
./mvnw -DskipTests package
