#
# perpetis
#
.DEFAULT_GOAL := help

.PHONY: help

help: Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#
build: image ## Build image

image: ## Build image
	@echo "Building image..."
	@docker buildx bake

up: create-net ## Start containers
	@echo "Starting containers..."
	@docker compose up -d

down: ## Stop containers
	@echo "Stopping containers..."
	@docker compose down

ps: ## Show status of services
	@echo "Status of services..."
	@docker compose ps

info: ## Show info of services
	@echo "Info of services..."
	@docker compose ps --format "table {{.Names}}\t{{.Ports}}"

update: ## Pull latest images
	@echo "Pulling latest images..."
	@docker compose pull --policy=always --ignore-buildable

reset: down ## Prune and remove data volumes
	@echo "Cleaning up..."
	@docker volume prune -f
	@docker volume rm perpetis_minio-data perpetis_postgres-data perpetis_redis-data

create-net: ## Create network
	@echo "Creating network..."
	@docker network inspect forbidden >/dev/null 2>&1 \
		|| docker network create forbidden

visit: ## Launch browser
	@echo "Visiting..."
	@./chrome.sh

.PHONY: build image up down ps info update reset create-net visit
##

