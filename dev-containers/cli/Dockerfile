ARG ARCH=arm64
ARG ALT_ARCH=aarch64

FROM dev-base:20240403

USER root
WORKDIR /

RUN apt install -y curl acl unzip wget

# Kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.2/bin/linux/arm64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# Kind
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-arm64 && \
  chmod +x ./kind && \
  mv ./kind /usr/local/bin/kind

# Docker CLI
RUN curl -LO https://download.docker.com/linux/static/stable/aarch64/docker-25.0.3.tgz && \
  tar -xf docker-25.0.3.tgz && \
  mv docker/docker /usr/local/bin/docker && \
  rm -rf docker-25.0.3.tgz docker && \
  touch /var/run/docker.sock && \
  setfacl -m u:dev:rw /var/run/docker.sock

# AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# 1password CLI
RUN wget https://cache.agilebits.com/dist/1P/op2/pkg/v2.26.1/op_linux_arm64_v2.26.1.zip -O op.zip && \
    unzip -d op op.zip && \
    mv op/op /usr/local/bin/ && \
    rm -r op.zip op && \
    groupadd -f onepassword-cli && \
    chgrp onepassword-cli /usr/local/bin/op && \
    chmod g+s /usr/local/bin/op

USER dev

WORKDIR /home/dev