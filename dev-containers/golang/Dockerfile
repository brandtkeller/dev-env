ARG TAG

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root

# Golang
RUN curl -LO https://go.dev/dl/go1.22.3.linux-${ARCH}.tar.gz && \
  tar -C /usr/local -xzf go1.22.3.linux-${ARCH}.tar.gz && \
  rm go1.22.3.linux-${ARCH}.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin:/home/dev/go/bin"

# Dev environment setup scripts
COPY dev-containers/golang/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="./home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work
