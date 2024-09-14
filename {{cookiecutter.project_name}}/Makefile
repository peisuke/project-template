# Makefile for managing Docker environment

# Variables
DOCKER_COMPOSE = docker-compose
SERVICE_NAME = jupyter

# Get the host user's UID and GID
USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

export USER_ID
export GROUP_ID

# Default target
.DEFAULT_GOAL := help

# Help target
help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  build        Build the Docker containers"
	@echo "  up           Start the Docker containers"
	@echo "  down         Stop the Docker containers"
	@echo "  clean        Remove Docker containers and volumes"
	@echo "  logs         Display logs for the running service"
	@echo "  shell        Open a shell in the running Docker container"

# Build the Docker containers
init:
	sh setup.sh

# Build the Docker containers
build:
	$(DOCKER_COMPOSE) build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID)

# Start the Docker containers
up: build
	$(DOCKER_COMPOSE) up

# Stop the Docker containers
down:
	$(DOCKER_COMPOSE) down

# Remove Docker containers and volumes
clean: down
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

# Display logs for the running service
logs:
	$(DOCKER_COMPOSE) logs -f $(SERVICE_NAME)

# Open a shell in the running Docker container
shell:
	$(DOCKER_COMPOSE) exec $(SERVICE_NAME) /bin/bash
