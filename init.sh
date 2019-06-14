#!/bin/bash

# Script to be run on very first setup.
# Replace dummy keys with real keys before beginning this

make deploy

docker exec tilehut_deployment_nginx_1 certbot certonly --nginx -d th.frb-data.dk --non-interactive --agree-tos -m gis@frederiksberg.dk

docker exec tilehut_deployment_nginx_1 sh -c 'echo ''certbot renew --post-hook "systemctl reload nginx"'' > /etc/cron.daily'

make kill