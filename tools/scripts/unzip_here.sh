#!/bin/sh
# Extract zip to current directory
if [ -z "$1" ]; then
  echo "Usage: unzip_here.sh <archive>" >&2
  exit 1
fi
unzip -oq "$1" -d .
