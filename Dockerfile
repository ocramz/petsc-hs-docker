FROM ocramz/petsc-docker

# # Update APT
RUN apt-get update


# # Get build tools
RUN apt-get install -y --no-install-recommends make gcc git libgmp-dev wget curl

# # fetch and make `petsc-hs`
RUN git clone https://github.com/ocramz/petsc-hs.git
RUN cd petsc-hs
RUN make