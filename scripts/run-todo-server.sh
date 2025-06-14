#!/bin/sh
# Simple helper to serve the todo-app via Python
PORT=8000
cd "$(dirname "$0")/../todo-app" || exit 1
python3 -m http.server "$PORT"
