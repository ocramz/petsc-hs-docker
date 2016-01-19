FROM ocramz/petsc-docker

# # Update APT
RUN apt-get update

# # TLS-related
RUN apt-get install -y --no-install-recommends ca-certificates debian-keyring debian-archive-keyring
RUN apt-key update


# # Set up environment variables
ENV LOCAL_DIR $HOME/.local
ENV BIN_DIR $HOME/.local/bin
ENV SRC_DIR $HOME/src
ENV PETSCHS_DIR $SRC_DIR/petsc-hs


ENV PATH $BIN_DIR:$PATH

ENV PETSC_INCLUDE1 $PETSC_DIR/include/
ENV PETSC_INCLUDE2 $PETSC_DIR/$PETSC_ARCH/include/
ENV PETSC_LIB $PETSC_DIR/$PETSC_ARCH/lib/


# # NB : assumes SLEPC_ARCH is defined
ENV SLEPC_INCLUDE1 $SLEPC_DIR/include/
ENV SLEPC_INCLUDE2 $SLEPC_DIR/$SLEPC_ARCH/include/
ENV SLEPC_LIB $SLEPC_DIR/$SLEPC_ARCH/lib/


# # Create directories
RUN mkdir -p $LOCAL_DIR
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR

# # print PETSc/SLEPc env variables to stdout:
RUN echo $PETSC_DIR
RUN echo $PETSC_ARCH
RUN echo $SLEPC_DIR
RUN echo $SLEPC_ARCH
RUN echo $PETSC_LIB
RUN echo $SLEPC_LIB

# # Get build tools
RUN apt-get install -y --no-install-recommends make gcc git libgmp-dev wget curl xz-utils

# # Get `stack`
WORKDIR $BIN_DIR
# RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $BIN_DIR '*/stack'
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $BIN_DIR '*/stack'
RUN ls -lsA

# # Add `stack` path
ENV PATH $(stack --stack-yaml stack.yaml path --local-install-root):$PATH


# # fetch and make `petsc-hs`
WORKDIR $SRC_DIR
RUN git clone https://github.com/ocramz/petsc-hs.git

WORKDIR $PETSCHS_DIR
RUN stack build $STACK_ARGS --no-terminal --install-ghc --extra-include-dirs=$PETSC_INCLUDE1 --extra-include-dirs=$PETSC_INCLUDE2 --extra-include-dirs=$SLEPC_INCLUDE1 --extra-include-dirs=$SLEPC_INCLUDE2 --extra-lib-dirs=$PETSC_LIB --extra-lib-dirs=$SLEPC_LIB



# # run example function
RUN stack exec petsc-example