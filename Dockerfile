FROM ocramz/petsc-docker


# # Update APT
RUN apt-get update

# # Set up environment variables
ENV LOCAL_DIR $HOME/.local
ENV BIN_DIR $HOME/.local/bin
ENV SRC_DIR $HOME/src
ENV PETSCHS_DIR $SRC_DIR/petsc-hs

RUN export PATH=$BIN_DIR:$PATH

ENV PETSC_INCLUDE1 $PETSC_DIR/include/
ENV PETSC_INCLUDE2 $PETSC_DIR/$PETSC_ARCH/include/
ENV PETSC_LIB $PETSC_DIR/$PETSC_ARCH/lib/

ENV SLEPC_INCLUDE1 $SLEPC_DIR/include/
ENV SLEPC_INCLUDE2 $SLEPC_DIR/$SLEPC_ARCH/include/
ENV SLEPC_LIB $SLEPC_DIR/$SLEPC_ARCH/lib/


# # Create directories
RUN mkdir -p $LOCAL_DIR
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR


# # Get build tools
RUN apt-get install -y --no-install-recommends make gcc git libgmp-dev wget curl

# # Get `stack`
RUN echo $SSEP
WORKDIR $BIN_DIR
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $BIN_DIR '*/stack'
RUN ls -lsA

# # Add `stack` path
RUN export PATH=$(stack --stack-yaml stack.yaml path --local-install-root):$PATH

# # fetch and make `petsc-hs`
WORKDIR $SRC_DIR
RUN git clone https://github.com/ocramz/petsc-hs.git
WORKDIR $PETSCHS_DIR
RUN stack build $STACK_ARGS --no-terminal --install-ghc --extra-include-dirs=$PETSC_INCLUDE1 --extra-include-dirs=$PETSC_INCLUDE2 --extra-include-dirs=$SLEPC_INCLUDE1 --extra-include-dirs=$SLEPC_INCLUDE2 --extra-lib-dirs=$PETSC_LIB --extra-lib-dirs=$SLEPC_LIB
