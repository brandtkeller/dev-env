ARG TAG="latest"

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root

ARG GO_VERSION="1.24.0"
ARG CODE_VERSION="4.96.4"

ENV GO_VERSION=${GO_VERSION} \
  CODE_VERSION=${CODE_VERSION}

# Golang - https://go.dev/dl/
RUN curl -LO https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz && \
  rm go${GO_VERSION}.linux-${ARCH}.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin:/home/dev/go/bin"

# Dev environment setup scripts
COPY dev-containers/golang/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="/home/dev/dev.sh"' >> /home/dev/.bashrc

RUN mkdir -p /home/dev/.local/lib /home/dev/.local/bin

RUN curl -fL https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server-${CODE_VERSION}-linux-amd64.tar.gz | tar -C /home/dev/.local/lib -xz && \
  mv /home/dev/.local/lib/code-server-${CODE_VERSION}-linux-amd64 /home/dev/.local/lib/code-server-${CODE_VERSION} && \
  ln -s /home/dev/.local/lib/code-server-${CODE_VERSION}/bin/code-server /home/dev/.local/bin/code-server && \
  chown dev:dev /home/dev/.local

ENV PATH="${PATH}:/usr/local/go/bin:/home/dev/go/bin:/home/dev/.local/bin"

USER dev

RUN go install github.com/go-delve/delve/cmd/dlv@v1.23.0 && go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.5

RUN mkdir -p /home/dev/work

RUN mkdir -p /home/dev/.vscode

RUN mkdir -p /home/dev/.config/coder

COPY dev-containers/golang/workspaces/* /home/dev/.vscode

WORKDIR /home/dev/work

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--user-data-dir", "/home/dev/.config/coder"]