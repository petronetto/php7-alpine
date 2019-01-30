# BSD 3-Clause License
#
# Copyright (c) 2017, Juliano Petronetto
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

FROM alpine:3.8

LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>"

ENV BUILD_DEPS="autoconf g++ make php7-dev git php7-pear tzdata libmemcached-dev rabbitmq-c-dev zlib-dev" \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
# XDebug configs
    XDEBUG_ENABLE=0 \
    XDEBUG_REMOTE_PORT=9000 \
    XDEBUG_HOST=localhost \
    XDEBUG_LOG=/var/log/xdebug/xdebug.log \
    PHP_MEMCACHE_BRANCH=NON_BLOCKING_IO_php7 \
    PHP_MEMCACHED_VERSION=3.0.4-r1 \
    PHP_REDIS_VERSION=3.1.6 \
    PHP_MONGODB_VERSION=1.4.4-r0 \
    PHP_IGBINARY_VERSION=2.0.8 \
    PHP_OAUTH_VERSION=2.0.3 \
    PHP_SYSCONF_PATH=/etc/php7 \
# New Relic
    NEWRELIC_VERSION=8.5.0.235 \
    NEWRELIC_ENABLED=0 \
    NEWRELIC_APP_NAME="PHP Application" \
    NEWRELIC_LICENSE= \
    NEWRELIC_LOG_FILE=/var/log/newrelic/newrelic.log \
    NEWRELIC_LOG_LEVEL=info \
    NEWRELIC_DAEMON_LOG_FILE=/var/log/newrelic/daemon.log \
    NEWRELIC_DAEMON_LOG_LEVEL=info \
# PHP Configs
    PHP_MEMORY_LIMIT=256M \
    PHP_PRECISION=-1 \
    PHP_OUTPUT_BUFFERING=4096 \
    PHP_SERIALIZE_PRECISION=-1 \
    PHP_MAX_EXECUTION_TIME=60 \
    PHP_ERROR_REPORTING=E_ALL \
    PHP_DISPLAY_ERRORS=0 \
    PHP_DISPLAY_STARTUP_ERRORS=0 \
    PHP_TRACK_ERRORS=0 \
    PHP_LOG_ERRORS=1 \
    PHP_LOG_ERRORS_MAX_LEN=10240 \
    PHP_ACCESS_LOG=/var/log/php/access.log \
    PHP_POST_MAX_SIZE=20M \
    PHP_MAX_UPLOAD_FILESIZE=10M \
    PHP_MAX_FILE_UPLOADS=20 \
    PHP_MAX_INPUT_TIME=60 \
    PHP_VARIABLES_ORDER=EGPCS \
    PHP_REQUEST_ORDER=GP \
    PHP_OPCACHE_ENABLE=1 \
    PHP_OPCACHE_ENABLE_CLI=0 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=128 \
    PHP_OPCACHE_INTERNED_STRINGS_BUFFER=32 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=10000 \
    PHP_OPCACHE_USE_CWD=1 \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS=1 \
    PHP_OPCACHE_REVALIDATE_FREQ=2 \
    PHP_OPCACHE_ENABLE_FILE_OVERRIDE=0 \
    PHP_ZEND_ASSERTIONS=-1 \
    PHP_PM_ERROR_LOG=/var/log/php/fpm-error.log \
    PHP_PM=ondemand \
    PHP_PM_MAX_CHILDREN=100 \
    PHP_PM_START_SERVERS=20 \
    PHP_PM_MIN_SPARE_SERVERS=20 \
    PHP_PM_MAX_SPARE_SERVERS=20 \
    PHP_PM_PROCESS_IDLE_TIMEOUT=60s \
    PHP_PM_MAX_REQUESTS=500

# Copying the config files
COPY ./ /app

# Installing necessary packages
RUN set -ex; \
    apk --update upgrade --no-cache; \
    apk add --no-cache --virtual .build-deps ${BUILD_DEPS}; \
    apk add --no-cache \
        curl \
        zlib \
        ca-certificates \
        openssl \
        libmemcached \
        rabbitmq-c \
        php7 \
        php7-dom \
        php7-fpm \
        php7-cgi \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-pdo \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-fileinfo \
        php7-xml \
        php7-simplexml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-phar \
        php7-openssl \
        php7-json \
        php7-curl \
        php7-ctype \
        php7-session \
        php7-zlib \
        php7-tokenizer \
        php7-xdebug; \
# Configuring timezones
    cp /usr/share/zoneinfo/Etc/UTC /etc/localtime; \
    echo "UTC" | tee /etc/timezone; \
# install PHP driver
    git clone https://github.com/mongodb/mongo-php-driver.git /tmp/php-mongodb && \
    cd /tmp/php-mongodb && \
    git submodule update --init && \
    phpize && ./configure --with-php-config=/usr/bin/php-config7 && make all && make install && \
    cd .. && rm -rf /tmp/php-mongodb/ && \
    echo 'extension=mongodb.so' >> ${PHP_SYSCONF_PATH}/conf.d/mongodb.ini \
    ; \
    git clone --depth=1 -b ${PHP_MEMCACHE_BRANCH} https://github.com/websupport-sk/pecl-memcache.git /tmp/php-memcache && \
    cd /tmp/php-memcache && \
    phpize && ./configure --with-php-config=/usr/bin/php-config7 && make && make install && \
    cd .. && rm -rf /tmp/php-memcache/ && \
    echo 'extension=memcache.so' >> ${PHP_SYSCONF_PATH}/conf.d/memcache.ini \
    ; \
    git clone --depth=1 -b ${PHP_IGBINARY_VERSION} https://github.com/igbinary/igbinary.git /tmp/php-igbinary && \
    cd /tmp/php-igbinary && \
    phpize && ./configure CFLAGS="-O2 -g" --enable-igbinary --with-php-config=/usr/bin/php-config7 && make && make install && \
    cd .. && rm -rf /tmp/php-igbinary/ && \
    echo 'extension=igbinary.so' >> ${PHP_SYSCONF_PATH}/conf.d/igbinary.ini \
    ; \
    cd /tmp && wget https://pecl.php.net/get/oauth-${PHP_OAUTH_VERSION}.tgz && tar xvzf oauth-${PHP_OAUTH_VERSION}.tgz && \
    cd oauth-${PHP_OAUTH_VERSION} && \
    phpize && ./configure --with-php-config=/usr/bin/php-config7 && make && make install && \
    cd .. && rm -rf /tmp/${PHP_OAUTH_VERSION}/ && \
    echo 'extension=oauth.so' >> ${PHP_SYSCONF_PATH}/conf.d/oauth.ini \
    ; \
    git clone --depth=1 -b ${PHP_REDIS_VERSION} https://github.com/phpredis/phpredis.git /tmp/phpredis && \
    cd /tmp/phpredis && phpize &&  ./configure &&  make && make install && \
    cd .. && rm -rf /tmp/phpredis && \
    echo 'extension=redis.so' >> ${PHP_SYSCONF_PATH}/conf.d/redis.ini \
    ; \
    rm -rf /tmp/pear; \
# Create application folder
    mkdir -p /app; \
# Creating www-data user and group
    addgroup -g 1000 -S www-data; \
	adduser -u 1000 -D -S -h /app -s /sbin/nologin -G www-data www-data; \
# Installing New Relic Agent
    mkdir /opt && cd /opt; \
    curl -LOk http://download.newrelic.com/php_agent/archive/${NEWRELIC_VERSION}/newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz; \
    gzip -dc newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz | tar xf -;\
    ./newrelic-php5-${NEWRELIC_VERSION}-linux-musl/newrelic-install install;\
# Installing Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
# Compying PHP config files
    cp -a /app/config/php.ini /etc/php7/php.ini; \
    cp -a /app/config/www.conf /etc/php7/php-fpm.d/www.conf; \
    cp -a /app/config/php-fpm.conf /etc/php7/php-fpm.conf; \
    cp -a /app/config/xdebug.ini /etc/php7/conf.d/xdebug.ini; \
    cp -a /app/config/newrelic.ini /etc/php7/conf.d/newrelic.ini; \
# Cleaning
    apk del .build-deps; \
    rm -rf /var/cache/apk/*; \
    rm -rf /app/config;

WORKDIR /app

# The container shouldn't run as root, it can be a potential
# security issue, obviously, depending the enviroment
# but to ensure the security, we aren't going to run as root.
USER www-data

CMD ["/usr/sbin/php-fpm7"]
