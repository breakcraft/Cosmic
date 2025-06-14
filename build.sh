#!/bin/sh
# Abort on any error
set -e
# Build Cosmic using Maven wrapper
./mvnw -DskipTests package
