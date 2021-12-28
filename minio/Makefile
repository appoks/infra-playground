.DEFAULT_GOAL:=help

COMPOSE_ALL_FILES := -f docker-compose.yml
S3_SERVICES   := minio{1..4} nginx
# --------------------------

# load .env so that Docker Swarm Commands has .env values too. (https://github.com/moby/moby/issues/29133)
include .env
export

# --------------------------
.PHONY: setup all elk tools build down stop restart rm logs backup restore minio


all:		    ## Start MinIO and all its components.
	docker-compose ${COMPOSE_ALL_FILES} up -d --build ${S3_SERVICES}
minio:		    	## Start MinIO.
	docker-compose up -d
build:		## Build MinIO and all its extra components.
	@docker-compose ${COMPOSE_ALL_FILES} build ${S3_SERVICES}
ps:			## Show all running containers.
	@docker-compose ${COMPOSE_ALL_FILES} ps

down:			## Down MinIO and all its extra components.
	@docker-compose ${COMPOSE_ALL_FILES} down

stop:			## Stop MinIO and all its extra components.
	@docker-compose ${COMPOSE_ALL_FILES} stop ${S3_SERVICES}
	
restart:		## Restart MinIO and all its extra components.
	@docker-compose ${COMPOSE_ALL_FILES} restart ${S3_SERVICES}

rm:				## Remove MinIO and all its extra components containers.
	@docker-compose $(COMPOSE_ALL_FILES) rm -f ${S3_SERVICES}

logs:			## Tail all logs with -n 1000.
	@docker-compose $(COMPOSE_ALL_FILES) logs --follow --tail=1000 ${S3_SERVICES}

images:			## Show all Images of MinIO and all its extra components.
	@docker-compose $(COMPOSE_ALL_FILES) images ${S3_SERVICES}

backup:			## Backup MinIO volumes.
	@bash /tools/backup.sh

restore:		## Restore MinIO volumes.
	@bash /tools/restore.sh

prune:			## Remove MinIO Containers and Delete Volume Data
	@make swarm-rm || echo ""
	@make stop && make rm
	@docker volume prune -f


## Show this help.
help:
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
