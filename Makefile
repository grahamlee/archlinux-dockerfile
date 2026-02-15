BASE := archlinux:latest
TAG := grahamlee/archlinux:latest

default: build

build:
	docker pull --platform linux/amd64 ${BASE}
	docker build --platform linux/amd64 -t ${TAG} .
	docker system prune -f

push: build
	docker push ${TAG}
