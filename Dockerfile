FROM alpine:3.6

LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>"

ENV PHP_VERSION=7.1.9-r0 \
    IGBINARY_VERSION=2.0.4 \
    PHP_MEMCACHED_VERSION=3.0.3 \
    PHPREDIS_VERSION=3.1.4 \
    PHP_AMQP_VERSION=1.9.0 \
    MONGO_PHP_DRIVER_VERSION=1.1.10 \
    XDEBUG_ENABLE=0 \
    XDEBUG_REMOTE_PORT=9000 \
    XDEBUG_HOST=localhost

ENV PHP_MEMORY_LIMIT=256M \
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
    PHP_POST_MAX_SIZE=20M \
    PHP_MAX_UPLOAD_FILESIZE=10M \
    PHP_MAX_FILE_UPLOADS=20 \
    PHP_MAX_INPUT_TIME=60 \
    PHP_DATE_TIMEZONE=America/Sao_Paulo \
    PHP_VARIABLES_ORDER=EGPCS \
    PHP_REQUEST_ORDER=GP \
    PHP_SESSION_SERIALIZE_HANDLER=php_binary \
    PHP_SESSION_SAVE_HANDLER=files \
    PHP_SESSION_SAVE_PATH=/tmp \
    PHP_SESSION_GC_PROBABILITY=1 \
    PHP_SESSION_GC_DIVISOR=10000 \
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
    PHP_IGBINARY_COMPACT_STRINGS=1 \
    PHP_PM=ondemand \
    PHP_PM_MAX_CHILDREN=100 \
    PHP_PM_START_SERVERS=20 \
    PHP_PM_MIN_SPARE_SERVERS=20 \
    PHP_PM_MAX_SPARE_SERVERS=20 \
    PHP_PM_PROCESS_IDLE_TIMEOUT=60s \
    PHP_PM_MAX_REQUESTS=500

RUN apk upgrade --update --no-cache && \
    apk add --update --no-cache \
    ca-certificates \
    curl \
    bash

RUN apk add --update --no-cache \
    php7-session=${PHP_VERSION} \
    php7-mcrypt=${PHP_VERSION} \
    php7-soap=${PHP_VERSION} \
    php7-openssl=${PHP_VERSION} \
    php7-gmp=${PHP_VERSION} \
    php7-pdo_odbc=${PHP_VERSION} \
    php7-json=${PHP_VERSION} \
    php7-dom=${PHP_VERSION} \
    php7-pdo=${PHP_VERSION} \
    php7-zip=${PHP_VERSION} \
    php7-mysqli=${PHP_VERSION} \
    php7-sqlite3=${PHP_VERSION} \
    php7-pdo_pgsql=${PHP_VERSION} \
    php7-bcmath=${PHP_VERSION} \
    php7-gd=${PHP_VERSION} \
    php7-odbc=${PHP_VERSION} \
    php7-pdo_mysql=${PHP_VERSION} \
    php7-pdo_sqlite=${PHP_VERSION} \
    php7-gettext=${PHP_VERSION} \
    php7-xmlreader=${PHP_VERSION} \
    php7-xmlwriter=${PHP_VERSION} \
    php7-xmlrpc=${PHP_VERSION} \
    php7-xml=${PHP_VERSION} \
    php7-simplexml=${PHP_VERSION} \
    php7-bz2=${PHP_VERSION} \
    php7-iconv=${PHP_VERSION} \
    php7-pdo_dblib=${PHP_VERSION} \
    php7-curl=${PHP_VERSION} \
    php7-ctype=${PHP_VERSION} \
    php7-pcntl=${PHP_VERSION} \
    php7-posix=${PHP_VERSION} \
    php7-phar=${PHP_VERSION} \
    php7-opcache=${PHP_VERSION} \
    php7-mbstring=${PHP_VERSION} \
    php7-zlib=${PHP_VERSION} \
    php7-fileinfo=${PHP_VERSION} \
    php7-tokenizer=${PHP_VERSION} \
    php7-fpm=${PHP_VERSION} \
    php7-xdebug \
    php7=${PHP_VERSION}

RUN rm -rf /etc/php7/php.ini && \
    mkdir /app

RUN apk add --update --no-cache libmemcached rabbitmq-c

RUN apk add --update --no-cache --virtual .build-deps git file re2c autoconf make g++ php7-dev=${PHP_VERSION} libmemcached-dev cyrus-sasl-dev zlib-dev musl rabbitmq-c-dev pcre-dev && \
    git clone --depth=1 -b ${IGBINARY_VERSION} https://github.com/igbinary/igbinary.git /tmp/php-igbinary && \
    cd /tmp/php-igbinary && \
    phpize && ./configure CFLAGS="-O2 -g" --enable-igbinary && make && make install && \
    cd .. && rm -rf /tmp/php-igbinary/ && \
    echo 'extension=igbinary.so' >> /etc/php7/conf.d/igbinary.ini && \
    \
    git clone --depth=1 -b v${PHP_MEMCACHED_VERSION} https://github.com/php-memcached-dev/php-memcached.git /tmp/php-memcached && \
    cd /tmp/php-memcached && \
    phpize && ./configure --disable-memcached-sasl && make && make install && \
    cd .. && rm -rf /tmp/php-memcached/ && \
    echo 'extension=memcached.so' >> /etc/php7/conf.d/memcached.ini && \
    \
    git clone --depth=1 -b ${PHPREDIS_VERSION} https://github.com/phpredis/phpredis.git /tmp/php-redis && \
    cd /tmp/php-redis && \
    phpize &&  ./configure --enable-redis-igbinary && make && make install && \
    cd .. && rm -rf /tmp/php-redis/ && \
    echo 'extension=redis.so' >> /etc/php7/conf.d/redis.ini && \
    \
    git clone --depth=1 -b v${PHP_AMQP_VERSION} https://github.com/pdezwart/php-amqp.git /tmp/php-amqp && \
    cd /tmp/php-amqp && \
    phpize && ./configure && make && make install && \
    cd .. && rm -rf /tmp/php-amqp/ && \
    echo 'extension=amqp.so' >> /etc/php7/conf.d/amqp.ini && \
    \
    git clone --depth=1 -b ${MONGO_PHP_DRIVER_VERSION} https://github.com/mongodb/mongo-php-driver.git /tmp/php-mongodb && \
    cd /tmp/php-mongodb && \
    git submodule update --init && \
    phpize && ./configure --prefix=/usr && make && make install && \
    cd .. && rm -rf /tmp/php-mongodb/ && \
    echo 'extension=mongodb.so' >> /etc/php7/conf.d/mongodb.ini && \
    \
    apk del .build-deps

COPY ./config/php.ini /etc/php7/php.ini
COPY ./config/www.conf /etc/php7/php-fpm.d/www.conf
COPY ./config/php-fpm.conf /etc/php7/php-fpm.conf
COPY ./config/xdebug.ini /etc/php7/conf.d/xdebug.ini

RUN addgroup -g 1000 -S www-data && \
	adduser -u 1000 -D -S -h /app -s /sbin/nologin -G www-data www-data

WORKDIR /app

USER www-data

CMD ["/usr/sbin/php-fpm7"]