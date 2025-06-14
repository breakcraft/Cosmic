#!/bin/sh
# Start Cosmic server using the pre-built jar in offline mode
DIR="$(dirname "$0")"
cd "$DIR" || exit 1
java -Xmx2048m -Dwz-path=wz -jar target/Cosmic.jar
