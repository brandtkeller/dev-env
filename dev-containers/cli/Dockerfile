ARG TAG

FROM dev-base:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"


USER root
WORKDIR /

RUN apt install -y curl acl unzip wget

# kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.29.2/bin/linux/${ARCH}/kubectl" && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# Kind
RUN curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-${ARCH}" && \
  chmod +x ./kind && \
  mv ./kind /usr/local/bin/kind

# Docker CLI
RUN curl -LO "https://download.docker.com/linux/static/stable/${ALT_ARCH}/docker-25.0.3.tgz" && \
  tar -xf docker-25.0.3.tgz && \
  mv docker/docker /usr/local/bin/docker && \
  rm -rf docker-25.0.3.tgz docker && \
  touch /var/run/docker.sock && \
  setfacl -m u:dev:rw /var/run/docker.sock

# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-${ALT_ARCH}.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -rf awscliv2.zip aws

# 1password CLI
RUN wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.26.1/op_linux_${ARCH}_v2.26.1.zip" -O op.zip && \
  unzip -d op op.zip && \
  mv op/op /usr/local/bin/ && \
  rm -r op.zip op && \
  groupadd -f onepassword-cli && \
  chgrp onepassword-cli /usr/local/bin/op && \
  chmod g+s /usr/local/bin/op

# Zarf
RUN curl -LO "https://github.com/defenseunicorns/zarf/releases/download/v0.32.6/zarf_v0.32.6_Linux_${ARCH}" && \
  mv zarf_v0.32.6_Linux_${ARCH} zarf && \
  chmod +x zarf && \
  mv zarf /usr/local/bin/zarf

# Lula
RUN curl -LO "https://github.com/defenseunicorns/lula/releases/download/v0.1.0/lula_v0.1.0_Linux_${ARCH}" && \
  mv lula_v0.1.0_Linux_${ARCH} lula && \
  chmod +x lula && \
  mv lula /usr/local/bin/lula

RUN echo '\nalias docker_sock="sudo setfacl -m u:dev:rw /var/run/docker.sock"'>> /home/dev/.bashrc

USER dev

WORKDIR /home/dev