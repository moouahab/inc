# Nom du projet (modifie-le selon tes besoins)
PROJECT_NAME = inception

# Répertoires et fichiers importants
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
SECRETS_DIR = secrets

# Commande Docker Compose avec le bon fichier
DOCKER_COMPOSE = docker-compose -p $(PROJECT_NAME) -f $(DOCKER_COMPOSE_FILE)

# Cibles
.PHONY: all build up start down stop restart logs clean secrets check ps

# Construire les conteneurs Docker
build: check_secrets
	$(DOCKER_COMPOSE) build

# Démarrer les services en arrière-plan
up: check_secrets
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

# Gérer les secrets (exemple pour copier les secrets)
secrets: check_secrets
	@echo "Copie des fichiers de secrets si nécessaire..."
	# Exemple pour gérer les secrets
	# cp $(SECRETS_DIR)/db_password.txt $(SECRETS_DIR)/credentials.txt ...

# Vérification des secrets avant de lancer les services
check_secrets:
	@if [ ! -f $(SECRETS_DIR)/db_password.txt ]; then \
		echo "Erreur : $(SECRETS_DIR)/db_password.txt est manquant."; \
		exit 1; \
	fi
	@if [ ! -f $(SECRETS_DIR)/db_root_password.txt ]; then \
		echo "Erreur : $(SECRETS_DIR)/db_root_password.txt est manquant."; \
		exit 1; \
	fi

# Vérifier l'état des conteneurs
ps:
	$(DOCKER_COMPOSE) ps

# Pour démarrer le projet en une commande
all: build up
