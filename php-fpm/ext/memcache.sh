#!/bin/bash

git clone --depth=1 -b ${PHP_MEMCACHE_BRANCH} https://github.com/websupport-sk/pecl-memcache.git /tmp/php-memcache
cd /tmp/php-memcache
phpize
./configure --with-php-config=/usr/bin/php-config7
make
make install
cd .. && rm -rf /tmp/php-memcache/
echo 'extension=memcache.so' >> ${PHP_SYSCONF_PATH}/conf.d/memcache.ini
