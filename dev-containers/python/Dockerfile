ARG TAG="latest"

FROM dev-cli:$TAG

USER root

# https://www.python.org/downloads/source/
ENV PYTHON_VERSION='3.12.6'

WORKDIR /
# Install needed packages
RUN apt install -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libsqlite3-dev

WORKDIR /tmp

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-loadable-sqlite-extensions --enable-optimizations && \
    make install

COPY dev-containers/python/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="./home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work

ENV SHELL=/bin/bash
