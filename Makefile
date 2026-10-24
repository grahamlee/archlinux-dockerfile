BASE := docker.io/library/archlinux:latest
TAG := docker.io/grahamlee/archlinux:latest

default: build

build:
	podman pull --platform linux/amd64 ${BASE}
	podman build --platform linux/amd64 -t ${TAG} .
	podman system prune -f

push: build
	podman push ${TAG}
