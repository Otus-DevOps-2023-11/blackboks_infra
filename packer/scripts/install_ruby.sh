#!/bin/bash
echo "Install ruby"
rm /var/lib/dpkg/lock*
rm /var/lib/apt/lists/lock*
rm /var/cache/apt/archives/lock*
apt update
apt install -y ruby-full ruby-bundler build-essential
