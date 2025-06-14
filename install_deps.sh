#!/bin/bash
# Install dependencies for building Cosmic
set -e
sudo apt-get update
sudo apt-get install -y openjdk-21-jdk maven mysql-server mysql-client apt-utils
