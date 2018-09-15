FROM php:7.1-fpm-alpine
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli

# Install gd
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
  ; \
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
  docker-php-ext-install -j$(nproc) gd

RUN apk --update --no-cache add imagemagick imagemagick-dev ${PHPIZE_DEPS} \ 
  && yes ""|pecl install imagick \
  && docker-php-ext-enable imagick \
  && apk del imagemagick-dev ${PHPIZE_DEPS}

RUN docker-php-ext-install zip mbstring json opcache




