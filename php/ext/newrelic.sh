#!/bin/bash

mkdir /opt && cd /opt
curl -LOk http://download.newrelic.com/php_agent/archive/${NEWRELIC_VERSION}/newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz
gzip -dc newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz | tar xf -
./newrelic-php5-${NEWRELIC_VERSION}-linux-musl/newrelic-install install
cp -a /app/config/newrelic.ini /etc/php7/conf.d/newrelic.ini
