.DEFAULT_GOAL:=help

MAKE_INFRA_SERVICES := 
# --------------------------


# --------------------------
.PHONY: setup all build down stop restart rm logs backup restore keycloak


setup:		##Setup everything needed to run this infra
	@echo "==============================================="
	@echo ""
	@echo "       Setting infrastructure services up      "
	@echo ""
	@echo "==============================================="
	@sleep 1
	@echo "====>  Bootstraping Elastic Stack!"
	@echo ""
	(cd elastic/ && make setup )
	@echo ""
	@echo ""
	@echo "==============================================="


infra:		## Initialize all resources required by the infra.
	@echo "==============================================="
	@echo ""
	@echo "      Starting all infrastructure services     "
	@echo ""
	@echo "==============================================="
	@sleep 1
	@echo ""
	@echo "====>  Starting Databases!"
	@echo ""
	(cd postgres/ && make postgres )
	@echo ""
	@sleep 10
	@echo "====>  Starting Message Brokers!"
	@echo ""
	(cd kafka/ && make kafka )
	@echo ""
	@sleep 1
	@echo "====>  Starting Object Storage!"
	@echo ""
	(cd minio/ && make minio )
	@echo ""
	@sleep 1
	@echo "====>  Starting Elastic Stack!"
	@echo ""
	(cd elastic/ && make elastic )
	@echo ""
	@sleep 1
	@echo "====>  Starting Auth Services!"
	@echo ""
	(cd keycloak/ && make keycloak )
	@echo ""
	@sleep 1
	@echo "====>  Starting Application Proxy!"
	@echo ""
#	(cd nginx/ && make nginx )
	@sleep 1
	@echo "==============================================="
	@echo ""
	@echo "You can now start your application and services"
	@echo ""
	@echo "==============================================="
	@echo ""

application:	## Initialize your application server.
	@echo ""
	@echo "====>  Starting Main Application"
	@echo ""
	@echo "Put here the commands to run your application"
	@echo ""

services:		## Initialize all custom services required by your application.
	@echo ""
	@echo "====>  Starting Custom Services"
	@echo ""
	@echo " Put here the commands to run your services"
	@echo ""

all:			## Initialize everything
	@make infra 
	@make application 
	@make services

down:			## Stop (docker down) infrastructure services
	@echo "==============================================="
	@echo ""
	@echo "      Stopping all infrastructure services     "
	@echo ""
	@echo "==============================================="
	@sleep 1
	@echo ""
	@echo "====>  Stopping Auth Services!"
	@echo ""
	(cd keycloak/ && make down )
	@echo ""
	@sleep 1
	@echo "====>  Stopping Message Brokers!"
	@echo ""
	(cd kafka/ && make down )
	@echo ""
	@sleep 1
	@echo "====>  Stopping Object Storage!"
	@echo ""
	(cd minio/ && make down )
	@echo ""
	@sleep 1
	@echo "====>  Stopping Elastic Stack!"
	@echo ""
	(cd elastic/ && make down )
	@echo ""
	@sleep 1
	@echo "====>  Stopping Databases!"
	@echo ""
	(cd postgres/ && make down )
	@echo ""
	@sleep 1
	@echo "====>  Stopping Application Proxy!"
	@echo ""
#	(cd nginx/ && make down )
	@echo ""
	@sleep 1
	@echo ""
	@echo "==============================================="


help:			## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
