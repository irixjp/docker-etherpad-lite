#!/bin/bash

if [ "$EP_USER" = "" -o "$EP_PASS" = "" ]; then
    echo "Error: you need to set envs with -e EP_USER=user -e EP_PASS=password"
    exit 1
fi

if [ -f /etc/nginx/.htpasswd ]; then
    :
else
    htpasswd -c -b /etc/nginx/.htpasswd ${EP_USER:?} ${EP_PASS:?}
fi

nginx

cd /eplite/etherpad-lite
exec node /eplite/etherpad-lite/node_modules/ep_etherpad-lite/node/server.js
