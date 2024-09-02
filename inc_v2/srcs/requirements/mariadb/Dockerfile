FROM debian:bullseye-slim

# Mettre à jour et installer MariaDB
RUN apt update -y && apt install mariadb-server -y

# Copier la configuration MariaDB personnalisée
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copier le script dans le container
COPY tools/setup-mariadb.sh /usr/local/bin/mariadb.sh

# Rendre le script exécutable
RUN chmod 755 /usr/local/bin/mariadb.sh

# Ajuster les permissions du répertoire de données MariaDB
RUN chown -R mysql:mysql /var/lib/mysql && chmod -R 755 /var/lib/mysql

EXPOSE 3306

# Définir l'entrée du conteneur
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]