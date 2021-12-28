.DEFAULT_GOAL:=help

MAKE_INFRA_FILES := 
# --------------------------


# --------------------------
.PHONY: setup all build down stop restart rm logs backup restore keycloak


infra:		## Initialize all resources required by the infra.
	@make -f postgres/Makefile pg


help:			## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
