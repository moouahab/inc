#!/bin/bash

# Vérifier que toutes les variables d'environnement nécessaires sont définies
if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_ROOT_PASSWORD" ]; then
    echo "Une ou plusieurs variables d'environnement nécessaires ne sont pas définies."
    exit 1
fi

echo "SQL_DATABASE is set to $SQL_DATABASE"

# Vérifier et arrêter tout processus MariaDB en cours proprement
if pgrep mysqld > /dev/null
then
    echo "Stopping existing MariaDB process"
    service mariadb stop
    sleep 5  # Attendre quelques secondes pour s'assurer que le service est bien arrêté
fi

# Démarrer le service MySQL/MariaDB
echo "Starting MariaDB service"
service mariadb start

# Ajouter un délai pour s'assurer que MariaDB est complètement démarré
sleep 5

# Vérifier si MariaDB est en cours d'exécution avant de continuer
if ! pgrep mysqld > /dev/null
then
    echo "MariaDB did not start successfully"
    exit 1
fi

# Créer la base de données si elle n'existe pas
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Créer l'utilisateur SQL s'il n'existe pas, avec accès global
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Configurer l'utilisateur root pour des connexions distantes
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD' WITH GRANT OPTION;"

# Rafraîchir les privilèges pour que les modifications prennent effet
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Arrêter proprement MariaDB avec mysqladmin shutdown
echo "Shutting down MariaDB with mysqladmin"
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown

# Attendre quelques secondes pour que MariaDB soit complètement arrêté
sleep 5

# Redémarrer MariaDB avec le service
echo "Restarting MariaDB service"
exec mysqld_safe

echo "MariaDB setup complete"
