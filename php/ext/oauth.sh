#!/bin/bash

cd /tmp && wget https://pecl.php.net/get/oauth-${PHP_OAUTH_VERSION}.tgz
tar xvzf oauth-${PHP_OAUTH_VERSION}.tgz
cd oauth-${PHP_OAUTH_VERSION}
phpize && ./configure --with-php-config=/usr/bin/php-config7
make
make install
cd .. && rm -rf /tmp/${PHP_OAUTH_VERSION}/
echo 'extension=oauth.so' >> ${PHP_SYSCONF_PATH}/conf.d/oauth.ini
