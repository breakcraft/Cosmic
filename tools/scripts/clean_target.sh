#!/bin/sh
set -e
# Remove Maven build outputs
# Run from the tools/scripts directory
find .. -name target -type d -exec rm -rf {} +
