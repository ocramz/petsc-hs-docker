# petsc-hs-docker

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-hs-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-hs-docker)

A Docker-based installation of [petsc-hs](http://github.com/ocramz/petsc-hs).

## Info


The PETSc and SLEPc libraries have been precompiled in a [Ubuntu-based image](https://hub.docker.com/r/ocramz/petsc-docker/), and `petsc-hs-docker` builds upon it.

PETSc is a large dependency that takes some 15 minutes to build on a fast machine. Moreover, a new version is released once every year, making it an approximately static target to develop against. 


## Usage

0. (make sure Docker is installed, preferably at the latest version, and if running on OSX or Windows a `docker-machine` VM should be up and running)

1. Download the image with `docker pull ocramz/petsc-hs-docker`

2. Run the image with `docker run -it --rm ocramz/petsc-hs-docker /bin/bash` and, at its prompt, build the latest version of `petsc-hs` with  `./update-petsc-hs.sh`. This will run the examples and leave the image open for experimentation.