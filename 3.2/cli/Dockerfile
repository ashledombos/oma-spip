FROM alpine
RUN apk update; \
    apk upgrade;

RUN apk add php php-phar php-xml php-openssl php-mbstring php-json subversion bash

COPY install_composer.sh /install_composer.sh

RUN sh /install_composer.sh \
    && mv composer.phar /usr/local/bin/composer \
    && rm install_composer.sh

RUN svn checkout svn://zone.spip.org/spip-zone/_outils_/spip-cli/trunk /opt/spip-cli \
    && cd /opt/spip-cli \
    && composer install \
    && ln -s /opt/spip-cli/bin/spip /usr/local/bin/spip

WORKDIR /app

CMD ["/bin/bash"]
