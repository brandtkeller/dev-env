FROM dev-cli:20240403

USER root

# Golang
RUN curl -LO https://go.dev/dl/go1.22.1.linux-arm64.tar.gz && \
  tar -C /usr/local -xzf go1.22.1.linux-arm64.tar.gz && \
  rm go1.22.1.linux-arm64.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin"

# Dev environment setup scripts
COPY dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo "\ndev_setup(){\n\t/home/dev/dev.sh\n}" >> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work
