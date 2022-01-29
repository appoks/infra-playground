.DEFAULT_GOAL:=help

COMPOSE_KC_ALL_FILES := -f docker-compose.yml
KEYCLOAK_SERVICES   := keycloak
# --------------------------

# load .env so that Docker Swarm Commands has .env values too. (https://github.com/moby/moby/issues/29133)
include .env
export

# --------------------------
.PHONY: setup all build down stop restart rm logs backup restore keycloak


all:			## Start Keycloak and all its component.
	docker-compose ${COMPOSE_KC_ALL_FILES} up -d --build ${KEYCLOAK_SERVICES}

keycloak:		## Start KeyCloak.
	docker-compose up -d

build:			## Build KeyCloak and all its extra components.
	@docker-compose ${COMPOSE_KC_ALL_FILES} build ${KEYCLOAK_SERVICES}

ps:				## Show all running containers.
	@docker-compose ${COMPOSE_KC_ALL_FILES} ps

down:			## Down KeyCloak and all its extra components.
	-@docker-compose ${COMPOSE_KC_ALL_FILES} down

stop:			## Stop KeyCloak and all its extra components.
	@docker-compose ${COMPOSE_KC_ALL_FILES} stop ${KEYCLOAK_SERVICES}
	
restart:		## Restart KeyCloak and all its extra components.
	@docker-compose ${COMPOSE_KC_ALL_FILES} restart ${KEYCLOAK_SERVICES}

rm:				## Remove KeyCloak and all its extra components containers.
	@docker-compose $(COMPOSE_KC_ALL_FILES) rm -f ${KEYCLOAK_SERVICES}

logs:			## Tail all logs with -n 1000.
	@docker-compose $(COMPOSE_keycloak_ALL_FILES) logs --follow --tail=1000 ${KEYCLOAK_SERVICES}

images:			## Show all Images of KeyCloak and all its extra components.
	@docker-compose $(COMPOSE_KC_ALL_FILES) images ${KEYCLOAK_SERVICES}

backup:			## Backup KeyCloak volume.
	@bash /tools/backup.sh

restore:		## Restore KeyCloak volume.
	@bash /tools/restore.sh

prune:			## Remove KeyCloak Containers and Delete Volume Data
	@make swarm-rm || echo ""
	@make stop && make rm
	@docker volume prune -f


help:			## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
