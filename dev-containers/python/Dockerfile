ARG TAG

FROM dev-cli:$TAG

USER root
WORKDIR /
# Install needed packages
RUN apt install -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libsqlite3-dev

WORKDIR /tmp

RUN wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz && \
    tar -xf Python-3.11.9.tgz && \
    cd Python-3.11.9 && \
    ./configure --enable-loadable-sqlite-extensions --enable-optimizations && \
    make install

RUN wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz && \
    tar -xf Python-3.12.2.tgz && \
    cd Python-3.12.2 && \
    ./configure --enable-loadable-sqlite-extensions --enable-optimizations && \
    make install

COPY dev-containers/python/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="./home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work

ENV SHELL=/bin/bash
