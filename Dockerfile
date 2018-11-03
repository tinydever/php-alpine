
FROM php:7.0-alpine3.7

RUN apk add libpng libpng-devel \
    libcurl \
    mysql \
    libjpeg \
    curl \
    libcurl \
    freetype

RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install shmop
RUN docker-php-ext-install sockets
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install xsl
RUN docker-php-ext-install iconv
RUN docker-php-ext-install zip
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install soap
RUN docker-php-ext-install intl
RUN docker-php-ext-install gettext
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install opcache


RUN pecl install redis\
  && pecl install mongodb \
  && pecl install memcached \
  && pecl install swoole \
  && docker-php-ext-enable redis mongodb  memcached swoole


#opcache
ENV OPCACHE_MAX_ACCELERATED_FILES 4000
ENV OPCACHE_REVALIDATE_FREQ 60
ENV OPCACHE_MEMORY_CONSUMPTION 128
ENV OPCAHCE_INTERNED_STRINGS_BUFFER 8
ENV OPCAHCE_FAST_SHUTDOWN 1
ENV OPCACHE_SAVE_COMMENTS 0

RUN  echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.interned_strings_buffer=${OPCAHCE_INTERNED_STRINGS_BUFFER}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.fast_shutdown=${OPCAHCE_FAST_SHUTDOWN}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.save_comments=${OPCACHE_SAVE_COMMENTS}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
