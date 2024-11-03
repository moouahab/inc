FROM debian:bullseye-slim


RUN apt-get update && apt-get install -y nginx openssl

RUN apt install vim curl -y

RUN mkdir -p /etc/nginx/ssl

# Générer le certificat SSL auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=moouahab.42.fr"

# Créer le répertoire pour le fichier PID de Nginx
RUN mkdir -p /var/run/nginx

# Copier la configuration personnalisée de Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# S'assurer que les permissions sont correctes pour le répertoire web
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

# Lancer Nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]