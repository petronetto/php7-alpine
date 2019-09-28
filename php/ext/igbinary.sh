#!/bin/bash

git clone --depth=1 -b ${PHP_IGBINARY_VERSION} https://github.com/igbinary/igbinary.git /tmp/php-igbinary
cd /tmp/php-igbinary
phpize
./configure CFLAGS="-O2 -g" --enable-igbinary --with-php-config=/usr/bin/php-config7
make
make install
cd .. && rm -rf /tmp/php-igbinary/
echo 'extension=igbinary.so' >> ${PHP_SYSCONF_PATH}/conf.d/igbinary.ini
