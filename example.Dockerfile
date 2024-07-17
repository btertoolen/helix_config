# If you want to include other dockerfiles, use this:
# INCLUDE+ .devcontainer/Dockerfile

# make sure to move this line to the top and set 
# DOCKER_BUILDKIT and DOCKER_BUILD_COMPOSE_CLI envs to 1
# syntax = edrevo/dockerfile-plus

# Switch to root user to install dependencies

FROM ubuntu:24.04
ARG CONTAINER_TERM=xterm-256color
ENV TERM=$CONTAINER_TERM

# Set up dev environment
RUN apt update && \
apt install software-properties-common -y && \
add-apt-repository ppa:maveonair/helix-editor && \
apt update && \
apt install curl ssh clangd git fonts-firacode ccls helix cmake clang build-essential make  zlib1g-dev libncurses-dev rapidjson-dev -y && \
curl -sS https://starship.rs/install.sh --yes | sh && \
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# COPY dependencies.txt /tmp/dependencies.txt
# RUN apt update \
#     && apt install -y $(cat /tmp/dependencies.txt) \
#        gdb nano vim \
#     && apt clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/dependencies.txt


RUN --mount=type=ssh mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    git clone git@github.com:btertoolen/helix_config.git --depth=1 /tmp/helix_config && \
    /tmp/helix_config/install.sh

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y  && \
    . $HOME/.cargo/env  && \
    rustup update && \
    cargo install --locked yazi-fm yazi-cli && \
    cargo install --locked zellij


RUN git clone https://github.com/luccahuguet/zellij.git ~/.config/zellij
