FROM ocramz/petsc-hs-docker-stage0

# # Update APT
# RUN apt-get update -yq --fix-missing && \
#     apt-get install -yq --no-install-recommends \
#                            make gcc git libgmp-dev wget curl xz-utils

ENV PATH=${PETSC_DIR}/${PETSC_ARCH}/lib/:$PATH
ENV PATH=${SLEPC_DIR}/${SLEPC_ARCH}/lib/:$PATH

# ------------------------------------------------------------
# SHOW ENVIRONMENT
# ------------------------------------------------------------
RUN printenv

# ------------------------------------------------------------
# SHOW PETSC CONFIGURE OPTIONS
# ------------------------------------------------------------
RUN cat ${PETSC_DIR}/${PETSC_ARCH}/lib/petsc/conf/configure.log | grep "Configure Options"

# ------------------------------------------------------------
# petsc-hs : clone repository and `stack setup`
# ------------------------------------------------------------
WORKDIR $SRC_DIR

# # retrieve petsc-hs repository
RUN git clone https://github.com/ocramz/petsc-hs.git

# # NB: assumes $PETSCHS_DIR is in $SRC_DIR
WORKDIR $PETSCHS_DIR

# # setup + first build of petsc-hs
RUN stack setup

# expand Stack-related path variables
RUN export STACK_PATH_1=$(stack --stack-yaml stack.yaml path --local-install-root) && \
    export DIST_DIR_1=$(stack path --dist-dir)/build

ENV PATH=${PETSC_DIR}/${PETSC_ARCH}/bin/:$PATH \
    PATH=${STACK_PATH_1}:${PATH} \
    MPIRUN_PATH=${PETSC_DIR}/${PETSC_ARCH}/bin

ENV PATH=${MPIRUN_PATH}:${PATH}


# ------------------------------------------------------------
# petsc-hs : install c2hs and build dependencies
# ------------------------------------------------------------

RUN stack install c2hs  && \
    ./stack-build.sh "--dependencies-only" "$PETSC_DIR" "$PETSC_ARCH" "$SLEPC_DIR" "$SLEPC_ARCH"


# ------------------------------------------------------------
# petsc-hs : delete PETSc-hs sources and build artifacts (dependencies are compiled in /.stack/ and safe)
# ------------------------------------------------------------

WORKDIR $SRC_DIR

RUN rm -rf petsc-hs/

# # copy update script (NB: hardcoded dir `/src`)
ADD update-petsc-hs.sh /src/

# # <===== NB : starting point to fetch and build `petsc-hs` from the github repo







# # # run example function
# RUN stack exec petsc-example

# # # ", using mpirun
# # RUN mpirun -n 2 $DIST_DIR/petsc-example/petsc-example



