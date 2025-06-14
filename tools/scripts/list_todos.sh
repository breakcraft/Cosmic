#!/bin/sh
set -e
# List TODO comments across the project or given paths
DIRS=${*:-"src todo-app docs"}
grep -R "TODO" $DIRS 2>/dev/null | grep -v jwzlib
