#!/bin/bash

git clone https://github.com/mongodb/mongo-php-driver.git /tmp/php-mongodb
cd /tmp/php-mongodb
git submodule update --init
phpize
./configure --with-php-config=/usr/bin/php-config7
make all
make install
cd .. && rm -rf /tmp/php-mongodb/
echo 'extension=mongodb.so' >> ${PHP_SYSCONF_PATH}/conf.d/mongodb.ini
