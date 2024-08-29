#!/bin/bash

# Attendre 20 secondes pour que la base de données soit prête
sleep 20

# Créer le fichier wp-config.php si nécessaire
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

# Créer le répertoire /run/php s'il n'existe pas
mkdir -p /run/php

# Lancer PHP-FPM avec la version correcte
/usr/sbin/php-fpm7.4 -F
