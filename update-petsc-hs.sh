#!/bin/bash

# environment variables
STACK_ARGS="$1"
PETSC_DIR="$2"    # install directory (e.g. "$HOME/petsc")
PETSC_ARCH="$3"   # architecture id.string (e.g. "arch-linux2-c-debug")
SLEPC_DIR="$4"
SLEPC_ARCH="$5"

# # fetch latest version of the library
# git clone https://github.com/ocramz/petsc-hs.git

# cd petsc-hs

# # synonym for `stack build ...`
./stack-build.sh "$STACK_ARGS" "$PETSC_DIR" "$PETSC_ARCH" "$SLEPC_DIR" "$SLEPC_ARCH"

# cd ..

stack path
