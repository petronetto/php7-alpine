#!/bin/bash

git clone https://github.com/swoole/swoole-src.git
cd swoole-src
phpize
./configure \
    --enable-sockets \
    --with-openssl-dir=/etc/ssl/ \
    --enable-http2
make
make install
cd .. && rm -rf swoole-src
echo 'extension=swoole.so' >> ${PHP_SYSCONF_PATH}/conf.d/swoole.ini
