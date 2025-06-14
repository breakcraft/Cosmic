#!/bin/bash
# Convenience script to start the server from source
set -e
./mvnw -DskipTests package
java -Xmx2048m -Dwz-path=wz -jar target/Cosmic.jar
