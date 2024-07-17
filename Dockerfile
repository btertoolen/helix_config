ARG BASE_IMAGE=ubuntu:24.04
FROM $BASE_IMAGE

# Switch to root user to install dependencies
USER root

ARG CONTAINER_TERM=xterm-256color
ENV TERM=$CONTAINER_TERM

# Set up dev environment
RUN apt update && \
apt install software-properties-common -y && \
add-apt-repository ppa:maveonair/helix-editor && \
apt update && \
apt install git fonts-firacode ccls helix cmake clang build-essential make  zlib1g-dev libncurses-dev rapidjson-dev -y && \
curl -sS https://starship.rs/install.sh --yes | sh && \
echo 'eval "$(starship init bash)"' >> ~/.bashrc

RUN --mount=type=ssh ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    git clone git@github.com:btertoolen/helix_config.git --depth=1 /tmp/helix_config && \
    ls -l /tmp && \
    /tmp/helix_config/install.sh
