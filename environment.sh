#!/bin/bash

# # Set up environment variables
# # NB : assumes SLEPC_ARCH is defined
export LOCAL_DIR=$HOME/.local
export BIN_DIR=$HOME/.local/bin
export SRC_DIR=$HOME/src
export PETSCHS_DIR=$SRC_DIR/petsc-hs
export PATH=$BIN_DIR:$PATH
export PETSC_INCLUDE1=$PETSC_DIR/include/
export PETSC_INCLUDE2=$PETSC_DIR/$PETSC_ARCH/include/
export PETSC_LIB=$PETSC_DIR/$PETSC_ARCH/lib/
export SLEPC_INCLUDE1=$SLEPC_DIR/include/
export SLEPC_INCLUDE2=$SLEPC_DIR/$SLEPC_ARCH/include/
export SLEPC_LIB=$SLEPC_DIR/$SLEPC_ARCH/lib/
