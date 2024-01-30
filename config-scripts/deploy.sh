#!/bin/bash
echo "Deploy application"
cd ~
sudo apt install git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
