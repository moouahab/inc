#!/bin/bash

# Attendre 20 secondes pour que la base de données soit prête
#sleep 20
# Créer le fichier wp-config.php si nécessaire
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php not found, creating from template...";
    mv /usr/src/wp-config-inc.php /var/www/wordpress/wp-config.php;
    chown www-data:www-data /var/www/wordpress/wp-config.php;
    chmod 644 /var/www/wordpress/wp-config.php;
fi

# Lancer PHP-FPM avec la version correcte
exec "$@"
