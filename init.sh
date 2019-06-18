#!/bin/bash

# Script to be run on very first setup.
# Replace dummy keys with real keys before beginning this

GREEN='\u001b[32;1m'
RESET='\u001b[0m'

echo -e "$GREEN--> Building host keys$RESET"
# Create host_keys
mkdir -p host_keys
ssh-keygen -t ed25519 -f host_keys/ssh_host_ed25519_key -N '' < /dev/null
ssh-keygen -t rsa -b 4096 -f host_keys/ssh_host_rsa_key -N '' < /dev/null

echo -e "$GREEN--> Deploying web server$RESET"
make deploy

echo -e "$GREEN--> Waiting 10s for nginx to gen DH keys$RESET"
sleep 10 # Sleep for 10 seconds. If this is not enough try again.

echo -e "$GREEN--> Getting certificate$RESET"
docker exec tilehut-deployment_nginx_1 certbot --nginx -d th.frb-data.dk -n --agree-tos --no-eff-email -m gis@frederiksberg.dk --staging

echo -e "$GREEN--> Setting up auto renewal$RESET"
docker exec tilehut-deployment_nginx_1 sh -c 'echo ''certbot renew --post-hook "systemctl reload nginx"'' > /etc/cron.daily'

echo -e "$GREEN--> Bringing down web server$RESET"
make kill