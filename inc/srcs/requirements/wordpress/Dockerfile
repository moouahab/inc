# Utiliser l'avant-dernière version stable de Debian slim
FROM debian:bullseye-slim

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt update -y && apt install -y wget

# Installer PHP 7.4 et les dépendances nécessaires
RUN apt-get install -y php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client

# Créer le répertoire pour le fichier PID de PHP-FPM
RUN mkdir -p /run/php

# Télécharger et décompresser WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Définir les permissions pour le dossier WordPress
RUN chown -R root:root /var/www/wordpress

# Modifier le fichier de configuration www.conf de PHP-FPM
RUN sed -i '/^;*clear_env\s*=\s*/c\clear_env = no' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i '/^;*listen\s*=\s*/c\listen = wordpress:9000' /etc/php/7.4/fpm/pool.d/www.conf

# Installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copier le script d'auto-configuration
COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

# Lancer le script d'auto-configuration
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
