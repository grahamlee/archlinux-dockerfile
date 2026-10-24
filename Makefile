BASE := docker.io/library/archlinux:latest
TAG := docker.io/grahamlee/archlinux:latest
DOCKERHUB_USER := grahamlee
DOCKERHUB_TOKEN_FILE := $(HOME)/.config/dockerhub/token

default: build

build:
	podman pull --platform linux/amd64 ${BASE}
	podman build --platform linux/amd64 -t ${TAG} .
	podman system prune -f

login:
	podman login docker.io -u ${DOCKERHUB_USER} --password-stdin < ${DOCKERHUB_TOKEN_FILE}

push: login build
	podman push ${TAG}
