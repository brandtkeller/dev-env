ARG TAG="latest"

FROM dev-cli:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

USER root
# https://github.com/nvm-sh/nvm/releases
ENV NVM_VERSION='v0.40.1'

# Dev environment setup scripts
COPY dev-containers/node/dev.sh /home/dev/

RUN chmod +x /home/dev/dev.sh

RUN echo '\nalias dev_setup="./home/dev/dev.sh"' >> /home/dev/.bashrc

USER dev

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
  export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
  nvm install lts/iron && \
  nvm use lts/iron

RUN mkdir -p /home/dev/work

WORKDIR /home/dev/work
