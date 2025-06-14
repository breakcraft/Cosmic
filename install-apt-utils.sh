#!/bin/bash
# Ensure apt-utils is installed for non-interactive package operations
set -e
if ! dpkg -s apt-utils >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y apt-utils
fi
