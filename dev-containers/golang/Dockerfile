ARG TAG="latest"

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root

ARG GO_VERSION="1.24.5"
ARG GORELEASER_VERSION="v2.10.2"

ENV GO_VERSION=${GO_VERSION} \
    GORELEASER_VERSION=${GORELEASER_VERSION}  

# Golang - https://go.dev/dl/
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  rm go${GO_VERSION}.linux-${ARCH}.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin:/home/dev/go/bin"

# GoReleaser - https://github.com/goreleaser/goreleaser/releases
RUN curl -LO "https://github.com/goreleaser/goreleaser/releases/download/${GORELEASER_VERSION}/goreleaser_Linux_${ALT_ARCH}.tar.gz" && \
  tar -zxf goreleaser_Linux_${ALT_ARCH}.tar.gz && \
  mv goreleaser /usr/local/bin/goreleaser && \
  rm goreleaser_Linux_${ALT_ARCH}.tar.gz LICENSE.md README.md && \
  rm -rf completions manpages

# Dev environment setup scripts
COPY dev-containers/golang/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="/home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

RUN go install github.com/go-delve/delve/cmd/dlv@v1.24.2 && go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.1.6 && go install golang.org/x/vuln/cmd/govulncheck@v1.1.4 && go install golang.org/x/tools/cmd/goimports@v0.35.0

RUN mkdir -p /home/dev/work

RUN mkdir -p /home/dev/.vscode

COPY dev-containers/golang/workspaces/* /home/dev/.vscode

WORKDIR /home/dev/work

CMD [ "sleep", "infinity" ]