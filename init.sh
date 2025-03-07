#!/bin/bash

if [ "$EP_USER" = "" -o "$EP_PASS" = "" ]; then
    :
else
    if [ -f /etc/nginx/.htpasswd ]; then
        :
    else
        htpasswd -c -b /etc/nginx/.htpasswd ${EP_USER:?} ${EP_PASS:?}
    fi
fi

nginx

cd /eplite/etherpad-lite
exec node /eplite/etherpad-lite/src/bin/run.sh
