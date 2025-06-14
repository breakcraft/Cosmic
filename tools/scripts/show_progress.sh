#!/bin/sh
# Show the end of progress log
DIR="$(dirname "$0")/../../"
 tail -n 15 "$DIR/progress.md"
