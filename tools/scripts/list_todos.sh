#!/bin/sh
set -e
# List TODO comments across the project
grep -R "TODO" src todo-app docs 2>/dev/null | grep -v jwzlib
