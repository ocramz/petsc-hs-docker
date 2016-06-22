ACCOUNT = ocramz
PROJECT = petsc-hs-docker
TAG = $(ACCOUNT)/$(PROJECT)

.DEFAULT_GOAL := help

help:
	@echo "Use \`make <target> \` where <target> is one of"
	@echo "  help     display this help message"
	@echo "  rbuild   build remotely (on Docker hub)"
	@echo "  build    build the docker image"
	@echo "  pull     download a pre-built image from Docker hub"
	@echo "  rebuild  '', ignoring previous builds"
	@echo "  run      build and run the image"

rbuild:
	curl -H "Content-Type: application/json" --data '{"build": true}' -X POST https://registry.hub.docker.com/u/ocramz/petsc-hs-docker/trigger/9b1da05d-2ac4-439f-9ffb-443faa37dfcc/


build:
	docker build -t $(TAG) .

pull:
	docker pull $(TAG)

rebuild:
	docker build --no-cache -t $(TAG) .

login:
	docker login -u $(ACCOUNT)

push: build login
	docker push $(TAG)

run:
	docker run -it --rm $(TAG) /bin/bash -c ./update-petsc-hs.sh

run_travis:
	docker run -it --rm $(TAG) /src/update-petsc-hs.sh

