#!/bin/bash
set -e

if ! [ -e index.php -a -e ecrire/inc_version.php ]; then
	echo >&2 "SPIP not found in $PWD - copying now..."
	if [ "$(ls -A)" ]; then
		echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
		( set -x; ls -A; sleep 10 )
	fi
	tar cf - --one-file-system -C /usr/src/spip . | tar xf -
	echo >&2 "Complete! SPIP has been successfully copied to $PWD"

  echo >&2 "Create plugins, libraries and template directories"
  mkdir -p plugins/auto; \
    mkdir -p lib; \
    mkdir -p squelettes; \
		mkdir -p tmp/{dump,log,upload}; \
		chown -R www-data:www-data plugins lib squelettes tmp

	if [ ! -e .htaccess ]; then
    cp htaccess.txt .htaccess
		chown www-data:www-data .htaccess
	fi
fi

# Install SPIP
if [ ! -e config/connect.php ]; then
	# Wait for mysql before install
	# cf. https://docs.docker.com/compose/startup-order/
		if [ ${SPIP_DB_SERVER} = "mysql" ]; then
			until mysql -h ${SPIP_DB_HOST} -u ${SPIP_DB_LOGIN} -p${SPIP_DB_PASS}; do
			  >&2 echo "mysql is unavailable - sleeping"
			  sleep 1
			done
		fi

		spip install \
			--db-server ${SPIP_DB_SERVER} \
			--db-host ${SPIP_DB_HOST} \
			--db-login ${SPIP_DB_LOGIN} \
			--db-pass ${SPIP_DB_PASS} \
			--db-database ${SPIP_DB_NAME} \
			--db-prefix ${SPIP_DB_PREFIX} \
			--admin-nom ${SPIP_ADMIN_NAME} \
			--admin-login ${SPIP_ADMIN_LOGIN} \
			--admin-email ${SPIP_ADMIN_EMAIL} \
			--admin-pass ${SPIP_ADMIN_PASS}

fi

exec "$@"
