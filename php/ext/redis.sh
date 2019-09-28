#!/bin/bash

git clone --depth=1 -b ${PHP_REDIS_VERSION} https://github.com/phpredis/phpredis.git /tmp/phpredis
cd /tmp/phpredis
phpize
./configure
make
make install
cd .. && rm -rf /tmp/phpredis
echo 'extension=redis.so' >> ${PHP_SYSCONF_PATH}/conf.d/redis.ini
