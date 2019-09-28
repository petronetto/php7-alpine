#!/bin/bash

apk --update upgrade --no-cache
apk add --no-cache php7-xdebug
cp -a /app/config/xdebug.ini /etc/php7/conf.d/xdebug.ini
