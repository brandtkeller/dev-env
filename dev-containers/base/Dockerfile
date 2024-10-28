FROM ubuntu:24.04

RUN apt update && apt install -y git build-essential vim

RUN groupadd --gid 1000 dev \
    && useradd --uid 1000 --gid 1000 -m dev \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo dev ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/dev \
    && chmod 0440 /etc/sudoers.d/dev

RUN echo "source /usr/share/bash-completion/completions/git" >> /home/dev/.bashrc

USER dev

WORKDIR /home/dev

ENV SHELL=/bin/bash