#!/bin/sh
set -e
# Remove Maven build outputs
find .. -name target -type d -exec rm -rf {} +
