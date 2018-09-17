FROM php:7.1-fpm-alpine
LABEL  maintainer "Laurent Vergerolle <docker@ipeos.com>"
LABEL  forked_from "https://github.com/ipeos-and-co/docker-spip"


RUN apk update;


# Install ghostscript
#  RUN apk add --no-cache \
#  ghostscript

# Install mcrypt
#RUN apk add --no-cache \
#  libmcrypt-dev \
#  ; \
#  docker-php-ext-install mcrypt

# Install libxml
RUN  apk add --no-cache\
  libxml2-dev;\
  docker-php-ext-install xml

# Install gd
RUN apk add --no-cache \
  freetype-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  ; \
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
  docker-php-ext-install -j$(nproc) gd

# Install mysql php extension
RUN docker-php-ext-install mysqli

# Install Imagick
RUN apk --update --no-cache add imagemagick imagemagick-dev ${PHPIZE_DEPS} \ 
  && yes ""|pecl install imagick \
  && docker-php-ext-enable imagick \
  && apk del imagemagick-dev ${PHPIZE_DEPS}

# Active over php extension
#RUN docker-php-ext-install zip mbstring json

# Add opcache
RUN docker-php-ext-install opcache

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=0'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini




