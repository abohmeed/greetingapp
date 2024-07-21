# Makefile for building and pushing Docker images

# Variables
BACKEND_IMAGE_NAME := greetingapp-backend
BACKEND_IMAGE_TAG := 1.0
FRONTEND_IMAGE_NAME := greetingapp-frontend
FRONTEND_IMAGE_TAG := 1.0
DOCKER_REGISTRY := afakharany
ECR_REGISTRY := 790250078024.dkr.ecr.eu-west-1.amazonaws.com
REGISTRY_TYPE := dockerhub # or ecr

# Declare phony targets
.PHONY: backend frontend ecr-login ecr-create-repo

# ECR login target
ecr-login:
	aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $(ECR_REGISTRY)

# ECR create repository target
ecr-create-repo:
	@aws ecr describe-repositories --repository-names $(BACKEND_IMAGE_NAME) --region eu-west-1 >/dev/null 2>&1 || aws ecr create-repository --repository-name $(BACKEND_IMAGE_NAME) --region eu-west-1 >/dev/null
	@aws ecr describe-repositories --repository-names $(FRONTEND_IMAGE_NAME) --region eu-west-1 >/dev/null 2>&1 || aws ecr create-repository --repository-name $(FRONTEND_IMAGE_NAME) --region eu-west-1 >/dev/null

# Backend target
backend: $(if $(filter ecr,$(REGISTRY_TYPE)),ecr-login ecr-create-repo)
	cd backend && docker build -t $(BACKEND_IMAGE_NAME) .
ifeq ($(REGISTRY_TYPE), ecr)
	docker tag $(BACKEND_IMAGE_NAME) $(ECR_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)
	docker push $(ECR_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)
else
	docker tag $(BACKEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)
	docker push $(DOCKER_REGISTRY)/$(BACKEND_IMAGE_NAME):$(BACKEND_IMAGE_TAG)
endif

# Frontend target
frontend: $(if $(filter ecr,$(REGISTRY_TYPE)),ecr-login ecr-create-repo)
	cd frontend && docker build -t $(FRONTEND_IMAGE_NAME) .
ifeq ($(REGISTRY_TYPE), ecr)
	docker tag $(FRONTEND_IMAGE_NAME) $(ECR_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
	docker push $(ECR_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
else
	docker tag $(FRONTEND_IMAGE_NAME) $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
	docker push $(DOCKER_REGISTRY)/$(FRONTEND_IMAGE_NAME):$(FRONTEND_IMAGE_TAG)
endif
