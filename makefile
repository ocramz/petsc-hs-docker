ACCOUNT = ocramz
PROJECT = petsc-hs-docker
TAG = $(ACCOUNT)/$(PROJECT)

.DEFAULT_GOAL := help

help:
	@echo "Use \`make <target> \` where <target> is one of"
	@echo "  help     display this help message"
	@echo "  build    build the docker image"
	@echo "  rebuild  '', ignoring previous builds"
	@echo "  login    login to your docker account"
	@echo "  push     push the image to the docker registry"
	@echo "  run      run the image"

build:
	docker build -t $(TAG) .

rebuild:
	docker build -no-cache -t $(TAG) .

login:
	docker login -u $(ACCOUNT)

push: build login
	docker push $(TAG)

run: 
	docker run -it --rm $(TAG)

