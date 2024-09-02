# Nom du projet
PROJECT_NAME = inception

# Commandes
.PHONY: all setup build up down clean fclean re

# Commandes
all: setup build up

setup:
	@echo "Création des dossiers nécessaires..."
	mkdir -p srcs/data/nginx
	mkdir -p srcs/data/wordpress
	mkdir -p srcs/data/mariadb

build:
	@echo "Construction des images Docker..."
	docker-compose -f srcs/docker-compose.yml build

up:
	@echo "Lancement des services..."
	docker-compose -f srcs/docker-compose.yml up -d

down:
	@echo "Arrêt des services..."
	docker-compose -f srcs/docker-compose.yml down

clean:
	@echo "Nettoyage des volumes et images Docker..."
	docker-compose -f srcs/docker-compose.yml down -v --rmi all

fclean: clean
	@echo "Suppression de toutes les traces du projet..."
	sudo rm -rf srcs/data
	docker system prune -af --volumes

re: fclean all

