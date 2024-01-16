#!/bin/bash
echo "Install mongodb"
rm /var/lib/dpkg/lock*
rm /var/lib/apt/lists/lock*
rm /var/cache/apt/archives/lock*
apt update
apt install mongodb -y
systemctl daemon-reload
systemctl enable mongodb
systemctl start mongodb
