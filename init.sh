#!/bin/bash

if [ "$EP_USER" = "" -o "$EP_PASS" = "" ]; then
    echo "You must set 'EP_USER' and 'EP_PASS'"
    exit 1
else
    if [ -f /etc/nginx/.htpasswd ]; then
        :
    else
        htpasswd -c -b /etc/nginx/.htpasswd ${EP_USER:?} ${EP_PASS:?}
    fi
fi

nginx

cd /root/etherpad-lite
exec pnpm run prod
