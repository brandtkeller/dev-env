ARG TAG="latest"

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root

ARG GO_VERSION="1.24.3"

ENV GO_VERSION=${GO_VERSION}

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

RUN go install github.com/go-delve/delve/cmd/dlv@v1.24.2 && go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.1.6 && go install golang.org/x/vuln/cmd/govulncheck@v1.1.4

RUN mkdir -p /home/dev/work

RUN mkdir -p /home/dev/.vscode

COPY dev-containers/golang/workspaces/* /home/dev/.vscode

WORKDIR /home/dev/work

CMD [ "sleep", "infinity" ]