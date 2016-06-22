FROM ocramz/petsc-docker:petsc-3.7.2

# # Update APT
RUN apt-get update -yq --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates && \
    apt-key update && \
    apt-get install -yq make gcc git libgmp-dev wget curl xz-utils


# # Set up environment variables
# # NB : assumes SLEPC_ARCH is defined
ENV LOCAL_DIR=$HOME/.local
    BIN_DIR=$HOME/.local/bin
    SRC_DIR=$HOME/src
    PETSCHS_DIR=$SRC_DIR/petsc-hs
    PATH=$BIN_DIR:$PATH
    PETSC_INCLUDE1=$PETSC_DIR/include/
    PETSC_INCLUDE2=$PETSC_DIR/$PETSC_ARCH/include/
    PETSC_LIB=$PETSC_DIR/$PETSC_ARCH/lib/
    SLEPC_INCLUDE1=$SLEPC_DIR/include/
    SLEPC_INCLUDE2=$SLEPC_DIR/$SLEPC_ARCH/include/
    SLEPC_LIB=$SLEPC_DIR/$SLEPC_ARCH/lib/


# # Create directories
RUN mkdir -p $LOCAL_DIR && \
    mkdir -p $BIN_DIR && \
    mkdir -p $SRC_DIR

# # print PETSc/SLEPc env variables to stdout:
RUN echo $PETSC_DIR && \
    echo $PETSC_ARCH && \
    echo $SLEPC_DIR && \
    echo $SLEPC_ARCH && \
    echo $PETSC_LIB && \
    echo $SLEPC_LIB && \
    echo $LD_LIBRARY_PATH && \
    echo $PKG_CONFIG_PATH && \
    printenv | grep bin





# # Get `stack`
WORKDIR $BIN_DIR

RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $BIN_DIR '*/stack'

# # Add `stack` path
ENV PATH=$(stack --stack-yaml stack.yaml path --local-install-root):$PATH
    DIST_DIR=$(stack path --dist-dir)/build
    PATH=$PETSC_DIR/$PETSC_ARCH/bin/:$PATH









WORKDIR $SRC_DIR


# # retrieve petsc-hs repository (NB: branch `petsc-3.7`)
RUN git clone -b petsc-3.7 https://github.com/ocramz/petsc-hs.git



WORKDIR $PETSCHS_DIR

# # setup + first build of petsc-hs
RUN stack setup && \
    ./stack-build.sh "--dependencies-only" "$PETSC_DIR" "$PETSC_ARCH" "$SLEPC_DIR" "$SLEPC_ARCH"


# # install c2hs
RUN stack install c2hs

# # # where is runhaskell?
# RUN find ${HOME} -name runhaskell







WORKDIR $SRC_DIR

# # delete PETSc-hs sources and build artifacts (dependencies are compiled in /.stack/ and safe)
RUN rm -rf petsc-hs/

# # copy update script (NB: hardcoded dir `/src`)
ADD update-petsc-hs.sh /src/

# # <===== NB : starting point to fetch and build `petsc-hs` from the github repo







# # # run example function
# RUN stack exec petsc-example

# # # ", using mpirun
# # RUN mpirun -n 2 $DIST_DIR/petsc-example/petsc-example






# # # clean temp data
RUN sudo apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*