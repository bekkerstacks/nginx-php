FROM alpine

WORKDIR /var/www/html

RUN apk add --no-cache curl ca-certificates && update-ca-certificates --fresh && apk add --no-cache openssl
RUN apk --no-cache add nginx \
        gzip pcre \
        php7 php7-curl \
        php7-fpm php7-gd \
        php7-mbstring php7-mysqli \
        php7-mysqlnd php7-opcache \
        php7-pdo php7-pdo_mysql \
        php7-xml php7-openssl \
        php7-zlib php7-json php7-zip

ADD config/app.conf /etc/nginx/conf.d/app.conf
ADD app/index.php /var/www/html/index.php

RUN rm -f /etc/nginx/conf.d/default.conf && mkdir -p /run/nginx && chown -R nginx:nginx /var/www/html

CMD php-fpm7 && nginx -g "daemon off;"
