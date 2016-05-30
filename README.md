# petsc-hs-docker

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-hs-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-hs-docker)

A Docker-based installation of [petsc-hs](http://github.com/ocramz/petsc-hs).

Info
----

The PETSc and SLEPc libraries have been precompiled in a [Ubuntu-based image](https://hub.docker.com/r/ocramz/petsc-docker/), and `petsc-hs-docker` builds upon it.

PETSc is a large dependency that takes some 15 minutes to build on a fast machine. Moreover, a new version is released once every year, making it an approximately static target to develop against. 
