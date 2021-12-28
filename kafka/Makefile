.DEFAULT_GOAL:=help

COMPOSE_KFK_ALL_FILES := -f docker-compose.yml
KAFKA_SERVICES   := kafka zookeeper
# --------------------------

# load .env so that Docker Swarm Commands has .env values too. (https://github.com/moby/moby/issues/29133)
include .env
export

# --------------------------
.PHONY: setup all build down stop restart rm logs kafka help


all:		## Start Kafka and all its component (Zookeeper for now).
	docker-compose ${COMPOSE_KFK_ALL_FILES} up -d --build ${S3_SERVICES}

kafka:		## Start Kafka.
	docker-compose up -d

build:		## Build Kafka and all its extra components.
	@docker-compose ${COMPOSE_KFK_ALL_FILES} build ${KAFKA_SERVICES}

ps:			## Show all running containers.
	@docker-compose ${COMPOSE_KFK_ALL_FILES} ps

down:		## Down Kafka and all its extra components.
	@docker-compose ${COMPOSE_KFK_ALL_FILES} down

stop:		## Stop Kafka and all its extra components.
	@docker-compose ${COMPOSE_KFK_ALL_FILES} stop ${KAFKA_SERVICES}

restart:	## Restart Kafka and all its extra components.
	@docker-compose ${COMPOSE_KFK_ALL_FILES} restart ${KAFKA_SERVICES}

rm:			## Remove Kafka and all its extra components containers.
	@docker-compose $(COMPOSE_KFK_ALL_FILES) rm -f ${KAFKA_SERVICES}

logs:		## Tail all logs with -n 1000.
	@docker-compose $(COMPOSE_KFK_ALL_FILES) logs --follow --tail=1000 ${KAFKA_SERVICES}

images:		## Show all Images of Kafka and all its extra components.
	@docker-compose $(COMPOSE_KFK_ALL_FILES) images ${KAFKA_SERVICES}

prune:		## Remove Containers and Delete Volume Data
	@make swarm-rm || echo ""
	@make stop && make rm
	@docker volume prune -f

help:		## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
