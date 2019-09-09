FROM php:7.2-fpm-alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" >> /etc/apk/repositories && \
    apk add --update nginx supervisor bash && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx

RUN mkdir -p /etc/nginx/sites-available && \
	mkdir -p /etc/nginx/sites-enabled && \
	mkdir -p /run/nginx

ADD supervisord.conf /etc/supervisord.conf
ADD nginx.conf /etc/nginx/nginx.conf

RUN chown nginx:www-data /etc/nginx -R && \
    chown nginx:www-data /run/nginx


RUN sed -i \
        -e "s/user = www-data/user = nginx/g" \
        -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
        -e "s/;listen.owner = www-data/listen.owner = nginx/g" \
        -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
        -e "s/^;clear_env = no$/clear_env = no/" \
        /usr/local/etc/php-fpm.d/www.conf

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
