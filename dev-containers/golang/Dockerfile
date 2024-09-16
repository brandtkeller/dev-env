ARG TAG

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root

ENV GO_VERSION='1.23.1'

# Golang - https://go.dev/dl/
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  rm go${GO_VERSION}.linux-${ARCH}.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin:/home/dev/go/bin"

# Dev environment setup scripts
COPY dev-containers/golang/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="/home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

RUN go install github.com/go-delve/delve/cmd/dlv@v1.23.0

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work
