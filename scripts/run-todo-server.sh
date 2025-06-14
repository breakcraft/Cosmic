#!/bin/sh
# Simple helper to serve the todo-app via Python
PORT=${1:-8000}
cd "$(dirname "$0")/../todo-app" || exit 1
echo "Serving todo-app on http://localhost:$PORT"
python3 -m http.server "$PORT"
