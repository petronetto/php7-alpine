FROM alpine:3.7

LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>"

ENV PHP_SERVER=php-fpm

ARG plugins=http.upload

RUN apk add --update openssh-client tar curl

RUN curl --silent --show-error --fail --location --header \
    "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
    "https://caddyserver.com/download/linux/amd64?plugins=${plugins}&license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy && \
    chmod 0755 /usr/bin/caddy && \
    addgroup -S caddy && \
    adduser -D -S -H -s /sbin/nologin -G caddy caddy && \
    /usr/bin/caddy -version

VOLUME /app

WORKDIR /app

ADD config/Caddyfile /etc/Caddyfile

RUN chown -R caddy:caddy /app

USER caddy

ENTRYPOINT ["/usr/bin/caddy"]

CMD ["--conf", "/etc/Caddyfile"]
