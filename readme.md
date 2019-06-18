# Deployment af tilehut

## Installation

To install clone the repo and enter the directory.

### Step 0: Prerequisites
You need to deploy this to a server that has a fully qualified domain name, and the ports 80, 443 and 2222 need to be free and open.

Other than that you need
* gmake
* docker
* docker-compose
* openssh

### Setp 1: Adding public keys
You can add public keys to the pub_keys directory. There needs to be at least one valid ssh key here before proceding to step 2.
Make sure to delete the dummy key file in the directory

### Step 2: Initialize the webserver
Replace the nginx/nginx/th.frb-data.dk file with one that describes your domain.

Also replace th.frb-data.dk with you domain name in the init.sh script.
And replace gis.frederiksberg.dk with an email you own.

Then run
```shell
# ./init.sh
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
