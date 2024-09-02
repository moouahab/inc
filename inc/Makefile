# Nom du projet (modifie-le selon tes besoins)
PROJECT_NAME = inception

# Répertoires et fichiers importants
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

# Commande Docker Compose avec le bon fichier
DOCKER_COMPOSE = docker-compose -p $(PROJECT_NAME) -f $(DOCKER_COMPOSE_FILE)

# Cibles
.PHONY: all build up start down stop restart logs clean secrets check ps

# Construire les conteneurs Docker
build:
	$(DOCKER_COMPOSE) build

# Démarrer les services en arrière-plan
up:
	$(DOCKER_COMPOSE) up -d

# Démarrer les services (attendu)
start:
	$(DOCKER_COMPOSE) start

# Arrêter les services
stop:
	$(DOCKER_COMPOSE) stop

# Redémarrer les services
restart: stop start

# Afficher les logs des services
logs:
	$(DOCKER_COMPOSE) logs -f

# Arrêter et supprimer les conteneurs, réseaux, volumes et images créés par up
down:
	$(DOCKER_COMPOSE) down

# Nettoyer les volumes et les images
clean: down
	$(DOCKER_COMPOSE) rm -v --force
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans



# Vérifier l'état des conteneurs
ps:
	$(DOCKER_COMPOSE) ps

# Pour démarrer le projet en une commande
all: build up
