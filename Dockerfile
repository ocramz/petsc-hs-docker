FROM ocramz/petsc-docker

# # Update APT
RUN apt-get update

# # Set up environment variables
ENV LOCAL_DIR $HOME/.local
ENV BIN_DIR $HOME/.local/bin
ENV SRC_DIR $HOME/src
ENV PETSCHS_DIR $SRC_DIR/petsc-hs

RUN export PATH=$BIN_DIR:$PATH

# # Create directories
RUN mkdir -p $LOCAL_DIR
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR


# # Get build tools
RUN apt-get install -y --no-install-recommends make gcc git libgmp-dev wget curl

# # Get `stack`
WORKDIR $BIN_DIR
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $BIN_DIR '*/stack'

# # fetch and make `petsc-hs`
WORKDIR $SRC_DIR
RUN git clone https://github.com/ocramz/petsc-hs.git
WORKDIR $PETSCHS_DIR
RUN make