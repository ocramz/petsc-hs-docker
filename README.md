# petsc-hs-docker

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-hs-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-hs-docker)

A Docker-based setup for [petsc-hs](http://github.com/ocramz/petsc-hs).

Info
----

The PETSc and SLEPc dependencies have been precompiled in a [Debian-based image](https://hub.docker.com/r/ocramz/petsc-docker/), upon which `petsc-hs-docker` is built.

The rationale for this choice is manifold: 

* PETSc is a large dependency that takes some 15 minutes to build on a fast machine. We use continuous integration (Travis CI) for testing so anything that cuts down testing time is a good thing (on the other hand, Travis must download a 4.3 GB set of files) so the tradeoff is between computation and bandwidth. So far it seems like computation is slower.

* We'd like to have a consistent, or, better still, identical, development/test environment, that works both on a laptop and a compute cluster by construction.