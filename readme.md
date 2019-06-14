# Deployment af tilehut

## Installation

To install clone the repo and enter the directory.

### Step 1: Sort your sftp keys

Generate host keys for the ftp server and place them in the host_keys directory.

You can use
```shell
# ssh-keygen -t ed25519 -f host_keys/ssh_host_ed25519_key < /dev/null
# ssh-keygen -t rsa -b 4096 -f host_keys/ssh_host_rsa_key < /dev/null
```

You can then add public keys to the pub_keys directory. Be sure to add at least one valid key.

Remember to remove the dummy keys that ship with the repo.

### Step 2: Initialize the webserver

Replace the nginx/nginx/th.frb-data.dk file with one that describes your domain.
You need to deploy this to a server that has a fully qualified domain name, and the ports 80, 443 and 2222 need to be free and open.

Also replace th.frb-data.dk with you domain name in the init.sh script.
And replace gis.frederiksberg.dk with an email you own.

Then run
```shell
# init.sh
```

This will setup nginx with https and and set up auto renewal.

### Step 3: Profit

Now simply run
```shell
# make
```
to run the tileserver with output or
```shell
# make deploy
```
to run the tileserver as a daemon.

The tilehut tileserver will now be available over https and all http traffic will be auto redirected.
