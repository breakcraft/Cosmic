#!/bin/sh
set -e
if [ ! -f target/Cosmic-*.jar ]; then
  ./build.sh
fi
java -jar target/Cosmic-*.jar "$@"
