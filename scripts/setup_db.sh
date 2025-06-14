#!/bin/sh
# Run all SQL setup scripts against MySQL
# Requires `apt-utils` for noninteractive installs on Debian/Ubuntu
set -e
if [ -z "$1" ]; then
  echo "Usage: $0 <mysql-root-password>"
  exit 1
fi
PASS="$1"
for f in database/sql/[1-4]-*.sql; do
  echo "Running $f"
  mysql -u root -p"$PASS" < "$f"
done
