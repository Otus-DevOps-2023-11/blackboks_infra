#!/bin/bash
echo "Deploy application"
cd ~
apt install git -y
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
