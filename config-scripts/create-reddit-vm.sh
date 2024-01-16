#!/bin/bash
echo "Creating reddit application instance.."
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --create-boot-disk image-family=reddit-full \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=cloud-init-reddit.yaml
