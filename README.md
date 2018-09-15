SPIP on Docker.

The application is splitted in 3 images based on Alpine linux:
spip-web: Apache
spip-fpm: php-fpm (includes also spip-cli)
spip-db: MariaDB

And it uses træfik as a reverse-proxy (Including Let's encrypt)
