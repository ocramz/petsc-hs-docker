#!/bin/bash

# # NB : PETSc/SLEPc environment variables must be already set at this stage
# printenv | grep PETSC ..

STACK_ARGS="$STACK_ARGS"
PETSC_DIR="$PETSC_DIR"
SLEPC_DIR="$SLEPC_DIR"
PETSC_ARCH="$PETSC_ARCH"
SLEPC_ARCH="$SLEPC_ARCH"

git clone https://github.com/ocramz/petsc-hs.git

cd petsc-hs

./stack-build.sh "$STACK_ARGS" "$PETSC_DIR" "$PETSC_ARCH" "$SLEPC_DIR" "$SLEPC_ARCH"

stack exec petsc-example
