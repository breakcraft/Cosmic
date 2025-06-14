#!/bin/sh
# Count total lines of code in src and todo-app
find ../../src ../../todo-app -type f -name '*.java' -o -name '*.js' -o -name '*.css' | xargs wc -l
