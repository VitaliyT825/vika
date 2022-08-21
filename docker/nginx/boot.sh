#!/usr/bin/env bash

set -ef

envsubst '${PROJECT_NAME},${DOMAIN}' < '/etc/nginx/app.conf.tpl' > '/etc/nginx/conf.d/default.conf'

nginx -g 'daemon off;'

