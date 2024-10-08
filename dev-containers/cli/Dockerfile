ARG TAG

FROM dev-base:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"


USER root
WORKDIR /

ENV KUBE_VERSION='v1.31.0' \
    HELM_VERSION='v3.16.1' \
    ORA_VERSION='1.2.0' \
    KIND_VERSION='v0.24.0' \
    K3D_VERSION='v5.7.4' \
    DOCKER_VERSION='27.2.1' \
    OP_VERSION='v2.30.0' \
    LULA_VERSION='v0.8.0' \
    UDS_VERSION='v0.16.0' \
    ZARF_VERSION='v0.40.1' \
    GH_VERSION='2.57.0' 

RUN apt install -y curl acl unzip wget rclone rsync

# kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
RUN curl -LO "https://dl.k8s.io/release/${KUBE_VERSION}/bin/linux/${ARCH}/kubectl" && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# helm - https://github.com/helm/helm/releases  
RUN curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz" && \
  tar -zxvf helm-${HELM_VERSION}-linux-${ARCH}.tar.gz && \
  mv linux-${ARCH}/helm /usr/local/bin/helm

# oras - https://github.com/oras-project/oras/releases
RUN curl -LO "https://github.com/oras-project/oras/releases/download/v${ORA_VERSION}/oras_${ORA_VERSION}_linux_${ARCH}.tar.gz" && \
  tar -zxvf oras_${ORA_VERSION}_linux_${ARCH}.tar.gz && \
  mv oras /usr/local/bin/oras

# Kind - https://github.com/kubernetes-sigs/kind/releases
RUN curl -Lo ./kind "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-${ARCH}" && \
  chmod +x ./kind && \
  mv ./kind /usr/local/bin/kind

# Docker CLI - https://download.docker.com/linux/static/stable
RUN curl -LO "https://download.docker.com/linux/static/stable/${ALT_ARCH}/docker-${DOCKER_VERSION}.tgz" && \
  tar -xf docker-${DOCKER_VERSION}.tgz && \
  mv docker/docker /usr/local/bin/docker && \
  rm -rf docker-${DOCKER_VERSION}.tgz docker && \
  touch /var/run/docker.sock && \
  setfacl -m u:dev:rw /var/run/docker.sock

# AWS CLI - 
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-${ALT_ARCH}.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -rf awscliv2.zip aws

# 1password CLI - https://developer.1password.com/docs/cli/get-started/
RUN wget "https://cache.agilebits.com/dist/1P/op2/pkg/${OP_VERSION}/op_linux_${ARCH}_${OP_VERSION}.zip" -O op.zip && \
  unzip -d op op.zip && \
  mv op/op /usr/local/bin/ && \
  rm -r op.zip op && \
  groupadd -f onepassword-cli && \
  chgrp onepassword-cli /usr/local/bin/op && \
  chmod g+s /usr/local/bin/op

# Zarf - https://github.com/zarf-dev/zarf/releases
RUN curl -LO "https://github.com/defenseunicorns/zarf/releases/download/${ZARF_VERSION}/zarf_${ZARF_VERSION}_Linux_${ARCH}" && \
  mv zarf_${ZARF_VERSION}_Linux_${ARCH} zarf && \
  chmod +x zarf && \
  mv zarf /usr/local/bin/zarf

# Lula
RUN curl -LO "https://github.com/defenseunicorns/lula/releases/download/${LULA_VERSION}/lula_${LULA_VERSION}_Linux_${ARCH}" && \
  mv lula_${LULA_VERSION}_Linux_${ARCH} lula && \
  chmod +x lula && \
  mv lula /usr/local/bin/lula

# UDS-CLI - https://github.com/defenseunicorns/uds-cli/releases
RUN curl -LO "https://github.com/defenseunicorns/uds-cli/releases/download/${UDS_VERSION}/uds-cli_${UDS_VERSION}_Linux_${ARCH}" && \
  mv uds-cli_${UDS_VERSION}_Linux_${ARCH} uds && \
  chmod +x uds && \
  mv uds /usr/local/bin/uds

# K3d - https://github.com/k3d-io/k3d/releases
RUN curl -LO "https://github.com/k3d-io/k3d/releases/download/${K3D_VERSION}/k3d-linux-${ARCH}" && \
  mv k3d-linux-${ARCH} k3d && \
  chmod +x k3d && \
  mv k3d /usr/local/bin/k3d

# Github CLI - https://github.com/cli/cli/releases
RUN curl -LO "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH}.tar.gz" && \
  tar -zxf gh_${GH_VERSION}_linux_${ARCH}.tar.gz && \
  mv gh_${GH_VERSION}_linux_${ARCH}/bin/gh /usr/local/bin/gh && \
  rm -rf gh_${GH_VERSION}_linux_${ARCH}.tar.gz && \
  rm -rf gh_${GH_VERSION}_linux_${ARCH}


RUN echo '\nalias docker_sock="sudo setfacl -m u:dev:rw /var/run/docker.sock"'>> /home/dev/.bashrc
RUN echo '\nalias k="kubectl"'>> /home/dev/.bashrc
RUN echo '\nalias one_pass="eval $(op signin)"'>> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/.config/op

WORKDIR /home/dev