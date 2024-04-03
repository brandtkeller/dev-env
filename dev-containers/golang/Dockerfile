FROM dev-cli:20240402

USER root

# Golang
RUN curl -LO https://go.dev/dl/go1.22.0.linux-arm64.tar.gz && \
  tar -C /usr/local -xzf go1.22.0.linux-arm64.tar.gz && \
  rm go1.22.0.linux-arm64.tar.gz

USER dev

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work