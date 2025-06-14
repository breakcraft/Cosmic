#!/bin/bash
# Simple script to test MySQL connectivity
mysqladmin ping -h "$1" --silent && echo "MySQL is up" || echo "MySQL is down"
