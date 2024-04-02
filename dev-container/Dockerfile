# TODO: add an architecture variable

FROM ubuntu:22.04

RUN apt update && \
  apt install -y curl

RUN groupadd --gid 1000 developer \
    && useradd --uid 1000 --gid 1000 -m developer \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo developer ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer

# Golang
RUN curl -LO https://go.dev/dl/go1.22.0.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz && \
  rm go1.22.0.linux-amd64.tar.gz

# Kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.2/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# Kind
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64 && \
  chmod +x ./kind && \
  mv ./kind /usr/local/bin/kind

# Docker CLI
RUN curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-25.0.3.tgz && \
  tar -xzf docker-25.0.3.tgz && \
  mv docker/docker /usr/local/bin/docker && \
  rm -rf docker-25.0.3.tgz docker

USER developer

