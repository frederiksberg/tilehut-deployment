#!/bin/bash

# Script to be run on very first setup.
# Replace dummy keys with real keys before beginning this

# Create host_keys
mkdir -p host_keys
ssh-keygen -t ed25519 -f host_keys/ssh_host_ed25519_key < /dev/null
ssh-keygen -t rsa -b 4096 -f host_keys/ssh_host_rsa_key < /dev/null

make deploy

docker exec tilehut-deployment_nginx_1 certbot certonly --nginx -d th.frb-data.dk --non-interactive --agree-tos -m gis@frederiksberg.dk

docker exec tilehut-deployment_nginx_1 sh -c 'echo ''certbot renew --post-hook "systemctl reload nginx"'' > /etc/cron.daily'

make kill