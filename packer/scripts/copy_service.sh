#!/bin/bash
echo "Copy unit file to /etc/systemd/system/"
cp /tmp/service /etc/systemd/system/reddit.service
systemctl enable reddit
systemctl start reddit
