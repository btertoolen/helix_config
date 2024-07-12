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
apt install fonts-firacode ccls helix cmake clang build-essential make  zlib1g-dev libncurses-dev rapidjson-dev -y && \
curl -sS https://starship.rs/install.sh --yes | sh && \
echo 'eval "$(starship init bash)"' >> ~/.bashrc

RUN apt update \
    && apt install -y $(cat /tmp/dependencies.txt) \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Switch back to non-root user
USER dev
