#!/bin/bash

# Script to be run on very first setup.
# Replace dummy keys with real keys before beginning this

GREEN='\u001b[32;1m'
YELLOW='\u001b[33;1m'
RESET='\u001b[0m'

echo -e "$GREEN--> Building host keys$RESET"
# Create host_keys
mkdir -p host_keys
ssh-keygen -t ed25519 -f host_keys/ssh_host_ed25519_key -N '' < /dev/null 2>&1 >/dev/null
ssh-keygen -t rsa -b 4096 -f host_keys/ssh_host_rsa_key -N '' < /dev/null 2>&1 >/dev/null

echo -e "$GREEN--> Deploying web server$RESET"
make deploy 2>&1 >/dev/null

echo -e "$GREEN--> Waiting 5s for nginx to initialize$RESET"
sleep 5 # Sleep for 5 seconds. If this is not enough try again.

echo -e "$GREEN--> Getting certificate$RESET"
echo -e "$YELLOW--> An invalid PID number error can occur here. This is fine$RESET"
docker exec tilehut-deployment_nginx_1 certbot --nginx -d th.frb-data.dk -nq --agree-tos --no-eff-email -m gis@frederiksberg.dk

echo -e "$GREEN--> Setting up auto renewal$RESET"
docker exec tilehut-deployment_nginx_1 sh -c 'echo ''certbot renew --post-hook "systemctl reload nginx"'' > /etc/cron.daily'

echo -e "$GREEN--> Bringing down web server$RESET"
make kill 2>&1 >/dev/null