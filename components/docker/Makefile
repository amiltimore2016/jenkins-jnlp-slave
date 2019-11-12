CURRENT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
IMAGE_NAME:=dockerhub.limitlessgames.cloud/infra/jenkins-slave-jnlp:${CURRENT_BRANCH}

build:
	docker build -t ${IMAGE_NAME} .
push:
	docker push ${IMAGE_NAME}

all: build push
