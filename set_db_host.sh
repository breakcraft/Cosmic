#!/bin/bash
# Set DB_HOST in config.yaml from env
[ -z "$DB_HOST" ] && { echo "DB_HOST not set"; exit 1; }
sed -i "s/^DB_HOST:.*$/DB_HOST: '$DB_HOST'/" config.yaml
