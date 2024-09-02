# # Utiliser l'avant-dernière version stable de Debian slim
# FROM debian:bullseye-slim

# # Mettre à jour les paquets et installer les dépendances nécessaires
# RUN apt update -y && apt install -y wget

# # Installer PHP 7.4 et les dépendances nécessaires
# RUN apt-get install -y php7.4 \
#     php-fpm \
#     php-mysql \
#     mariadb-client
    
# # Créer le répertoire pour le fichier PID de PHP-FPM
# RUN mkdir -p /run/php

# # Télécharger et décompresser WordPress
# RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
#     cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz


# # Définir les permissions pour le dossier WordPress
# RUN chown -R root:root /var/www/wordpress

# # Modifier le fichier de configuration www.conf de PHP-FPM
# RUN sed -i '/^;*clear_env\s*=\s*/c\clear_env = no' /etc/php/7.4/fpm/pool.d/www.conf
# RUN sed -i '/^;*listen\s*=\s*/c\listen = wordpress:9000' /etc/php/7.4/fpm/pool.d/www.conf

# # Copier le script d'auto-configuration
# COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
# COPY conf/wp-config.php /var/www/wordpress/wp-config.php
# RUN chmod +x /usr/local/bin/auto_config.sh


# # Lancer le script d'auto-configuration
# ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
# Utiliser l'avant-dernière version stable de Debian slim
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

# Télécharger et décompresser WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.0-fr_FR.tar.gz

# Définir les permissions pour le dossier WordPress
RUN chown -R www-data:www-data /var/www/wordpress

# Modifier le fichier de configuration www.conf de PHP-FPM
RUN sed -i '/^;*clear_env\s*=\s*/c\clear_env = no' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i '/^;*listen\s*=\s*/c\listen = 0.0.0.0:9000' /etc/php/7.4/fpm/pool.d/www.conf

# Copier le script d'auto-configuration et le fichier wp-config.php
COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
COPY --chown=www-data:www-data conf/wp-config-inc.php /usr/src/wp-config-inc.php

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/auto_config.sh


# Lancer le script d'auto-configuration
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Définir le répertoire de travail
WORKDIR /var/www/wordpress

EXPOSE 9000

# Commande par défaut pour démarrer PHP-FPM
CMD ["php-fpm7.4", "-F"]
