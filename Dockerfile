FROM ocramz/petsc-docker

# # Update APT
RUN apt-get update

# # Set up directories
RUN mkdir -p ~/.local/bin


# # Get build tools
RUN apt-get install -y --no-install-recommends make gcc git libgmp-dev wget curl

# # Get `stack`
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C $HOME/.local/bin '*/stack'

# # fetch and make `petsc-hs`
RUN git clone https://github.com/ocramz/petsc-hs.git
RUN cd petsc-hs
RUN make