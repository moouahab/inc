# Nom du projet
PROJECT_NAME = inception

# Commandes
.PHONY: all setup build up down clean fclean re

# Commandes
all: setup build up

setup:
	@echo "Création des dossiers nécessaires..."
	@if [ ! -f srcs/.env ]; then \
		wget -P ./srcs/ https://github.com/moouahab/inc/raw/main/inc_v2/srcs/.env; \
	fi
	mkdir -p /home/moouahab/data/nginx
	mkdir -p /home/moouahab/data/wordpress
	mkdir -p /home/moouahab/data/mariadb

build:
	@echo "Construction des images Docker..."
	docker-compose -f srcs/docker-compose.yml build

up:
	@echo "Lancement des services..."
	docker-compose -f srcs/docker-compose.yml up

down:
	@echo "Arrêt des services..."
	docker-compose -f srcs/docker-compose.yml down

clean:
	@echo "Nettoyage des volumes et images Docker..."
	@if [ ! -f srcs/.env ]; then \
		wget -P ./srcs/ https://github.com/moouahab/inc/raw/main/inc_v2/srcs/.env; \
	fi
	docker-compose -f srcs/docker-compose.yml down -v --rmi all

fclean: clean
	@echo "Suppression de toutes les traces du projet..."
	sudo docker-compose -f srcs/docker-compose.yml down
	sudo rm -rf /home/moouahab/data && rm -rf ./srcs/.env
	docker system prune -af --volumes
	rm -rf srcs/.env

re: fclean all

