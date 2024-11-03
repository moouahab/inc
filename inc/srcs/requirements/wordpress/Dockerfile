FROM debian:bullseye-slim

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update -y && apt-get install -y \
    wget \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    && apt-get clean

# Créer le répertoire pour le fichier PID de PHP-FPM
RUN mkdir -p /run/php

# Télécharger et décompresser WordPress directement dans le bon répertoire
# Download and extract WordPress directly into the /var/www/wordpress directory
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.0-fr_FR.tar.gz


RUN mkdir -p /var/www/wordpress

# Définir les permissions pour le dossier WordPress
RUN chown -R www-data:www-data /var/www/wordpress

# Modifier le fichier de configuration www.conf de PHP-FPM
RUN sed -i '/^;*clear_env\s*=\s*/c\clear_env = no' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i '/^;*listen\s*=\s*/c\listen = 0.0.0.0:9000' /etc/php/7.4/fpm/pool.d/www.conf

# Copier le script d'auto-configuration et le fichier wp-config.php
COPY tools/auto_config.sh /usr/local/bin/auto_config.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/auto_config.sh

# Lancer le script d'auto-configuration
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Définir le répertoire de travail
WORKDIR /var/www/wordpress

EXPOSE 9000

# Commande par défaut pour démarrer PHP-FPM
CMD ["php-fpm7.4", "-F"]
