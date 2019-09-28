FROM nginx:1.12-alpine

LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>"

# Install packages
RUN apk --update add --no-cache tzdata \
    && rm -rf /var/cache/apk/* \
    && cp /usr/share/zoneinfo/Etc/UTC /etc/localtime \
    && echo "UTC" > /etc/timezone \
    && apk del tzdata && rm -rf /var/cache/apk/* \
    && mkdir /app \
    && chown -R nginx:nginx /app \
    && chown -R nginx:nginx /var/cache/nginx /etc/nginx \
    && chmod -R g=u /var/cache/nginx /etc/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

USER nginx