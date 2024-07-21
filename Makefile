# Makefile for building and pushing Docker images

# Variables
BACKEND_IMAGE_NAME := greetingapp-backend
FRONTEND_IMAGE_NAME := greetingapp-frontend
DOCKER_REGISTRY := afakharany

# Declare phony targets
.PHONY: backend frontend

# Targets
backend:
	cd backend && docker build -t $(BACKEND_IMAGE_NAME) .
	docker tag $(BACKEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME)
	docker push $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME)

frontend:
	cd frontend && docker build -t $(FRONTEND_IMAGE_NAME) .
	docker tag $(FRONTEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME)
	docker push $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME)
