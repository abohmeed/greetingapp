# Makefile for building and pushing Docker images

# Variables
BACKEND_IMAGE_NAME := greetingapp-backend
BACKEND_IMAGE_TAG := 1.0
FRONTEND_IMAGE_NAME := greetingapp-frontend
FRONTEND_IMAGE_TAG := 1.0
DOCKER_REGISTRY := afakharany

# Declare phony targets
.PHONY: backend frontend

# Targets
backend:
	cd backend && docker build -t $(BACKEND_IMAGE_NAME) .
	docker tag $(BACKEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)
	docker push $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)

frontend:
	cd frontend && docker build -t $(FRONTEND_IMAGE_NAME) .
	docker tag $(FRONTEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
	docker push $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
