.DEFAULT_GOAL:=help

COMPOSE_PG_ALL_FILES := -f docker-compose.yml
PG_SERVICES   := postgresql pgadmin4
# --------------------------

# load .env so that Docker Swarm Commands has .env values too. (https://github.com/moby/moby/issues/29133)
include .env
export

# --------------------------
.PHONY: setup keystore certs all monitoring tools build down stop restart rm logs backup restore pg


all:		    ## Start PostgreSQL and all its component (pgAdmin4 for now).
	docker-compose ${COMPOSE_PG_ALL_FILES} up -d --build ${PG_SERVICES}
pg:		    	## Start PostgreSQL.
	docker-compose up
build:			## Build PostgreSQL and all its extra components.
	@docker-compose ${COMPOSE_PG_ALL_FILES} build ${PG_SERVICES}
ps:				## Show all running containers.
	@docker-compose ${COMPOSE_PG_ALL_FILES} ps

down:			## Down PostgreSQL and all its extra components.
	@docker-compose ${COMPOSE_PG_ALL_FILES} down

stop:			## Stop PostgreSQL and all its extra components.
	@docker-compose ${COMPOSE_PG_ALL_FILES} stop ${PG_SERVICES}
	
restart:		## Restart PostgreSQL and all its extra components.
	@docker-compose ${COMPOSE_PG_ALL_FILES} restart ${PG_SERVICES}

rm:				## Remove PostgreSQL and all its extra components containers.
	@docker-compose $(COMPOSE_PG_ALL_FILES) rm -f ${PG_SERVICES}

logs:			## Tail all logs with -n 1000.
	@docker-compose $(COMPOSE_PG_ALL_FILES) logs --follow --tail=1000 ${PG_SERVICES}

images:			## Show all Images of PostgreSQL and all its extra components.
	@docker-compose $(COMPOSE_PG_ALL_FILES) images ${PG_SERVICES}

backup:			## Backup PostgreSQL volume.
	@bash /tools/backup.sh

restore:		## Restore PostgreSQL volume.
	@bash /tools/restore.sh

prune:			## Remove PostgreSQL Containers and Delete Volume Data
	@make swarm-rm || echo ""
	@make stop && make rm
	@docker volume prune -f


help:       	## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
