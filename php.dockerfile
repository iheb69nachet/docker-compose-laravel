FROM php:7.4-fpm-alpine

ARG PHPGROUP
ARG PHPUSER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}; exit 0

RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/html/site1
RUN mkdir -p /var/www/html/site2


WORKDIR /var/www/html

RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-install pdo pdo_mysql

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN apk update
RUN apk upgrade
RUN apk add bash
RUN alias composer='php /usr/bin/composer'
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
