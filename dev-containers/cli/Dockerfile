ARG TAG="latest"

FROM dev-base:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"


USER root
WORKDIR /

ARG KUBE_VERSION="v1.33.0"
ARG HELM_VERSION="v3.18.3"
ARG ORA_VERSION="1.2.3"
ARG KIND_VERSION="v0.29.0"
ARG DOCKER_VERSION="28.3.0"
ARG DOCKER_BUILDX_VERSION="v0.25.0"
ARG K3D_VERSION="v5.8.3"
ARG OP_VERSION="v2.31.1"
ARG UDS_VERSION="v0.27.7"
ARG ZARF_VERSION="v0.57.0"
ARG GH_VERSION="2.74.2"
ARG HUGO_VERSION="0.147.9"
ARG COSIGN_VERSION="2.5.2"

ENV KUBE_VERSION=${KUBE_VERSION} \
    HELM_VERSION=${HELM_VERSION} \
    ORA_VERSION=${ORA_VERSION} \
    KIND_VERSION=${KIND_VERSION} \
    DOCKER_VERSION=${DOCKER_VERSION} \
    DOCKER_BUILDX_VERSION=${DOCKER_BUILDX_VERSION} \
    K3D_VERSION=${K3D_VERSION} \
    OP_VERSION=${OP_VERSION} \
    UDS_VERSION=${UDS_VERSION} \
    ZARF_VERSION=${ZARF_VERSION} \
    GH_VERSION=${GH_VERSION} \
    HUGO_VERSION=${HUGO_VERSION} \
    COSIGN_VERSION=${COSIGN_VERSION}

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

# cosign - https://github.com/sigstore/cosign/releases
RUN curl -LO "https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-${ARCH}" && \
  chmod +x cosign-linux-${ARCH} && \
  mv cosign-linux-${ARCH} /usr/local/bin/cosign

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

 # Docker Buildx -  https://github.com/docker/buildx/releases
RUN curl -LO "https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH}" && \
  mkdir -p /home/dev/.docker/cli-plugins && \
  mv buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH} /home/dev/.docker/cli-plugins/docker-buildx && \
  chmod +x /home/dev/.docker/cli-plugins/docker-buildx && \
  chown dev:dev /home/dev/.docker

# K3d - https://github.com/k3d-io/k3d/releases
RUN curl -LO "https://github.com/k3d-io/k3d/releases/download/${K3D_VERSION}/k3d-linux-${ARCH}" && \
  mv k3d-linux-${ARCH} k3d && \
  chmod +x k3d && \
  mv k3d /usr/local/bin/k3d

# 1password CLI - https://developer.1password.com/docs/cli/get-started/
RUN wget "https://cache.agilebits.com/dist/1P/op2/pkg/${OP_VERSION}/op_linux_${ARCH}_${OP_VERSION}.zip" -O op.zip && \
  unzip -d op op.zip && \
  mv op/op /usr/local/bin/ && \
  rm -r op.zip op && \
  groupadd -f onepassword-cli && \
  chgrp onepassword-cli /usr/local/bin/op && \
  chmod g+s /usr/local/bin/op

# UDS-CLI - https://github.com/defenseunicorns/uds-cli/releases
RUN curl -LO "https://github.com/defenseunicorns/uds-cli/releases/download/${UDS_VERSION}/uds-cli_${UDS_VERSION}_Linux_${ARCH}" && \
  mv uds-cli_${UDS_VERSION}_Linux_${ARCH} uds && \
  chmod +x uds && \
  mv uds /usr/local/bin/uds

# Zarf - https://github.com/zarf-dev/zarf/releases
RUN curl -LO "https://github.com/defenseunicorns/zarf/releases/download/${ZARF_VERSION}/zarf_${ZARF_VERSION}_Linux_${ARCH}" && \
  mv zarf_${ZARF_VERSION}_Linux_${ARCH} zarf && \
  chmod +x zarf && \
  mv zarf /usr/local/bin/zarf

# Github CLI - https://github.com/cli/cli/releases
RUN curl -LO "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH}.tar.gz" && \
  tar -zxf gh_${GH_VERSION}_linux_${ARCH}.tar.gz && \
  mv gh_${GH_VERSION}_linux_${ARCH}/bin/gh /usr/local/bin/gh && \
  rm -rf gh_${GH_VERSION}_linux_${ARCH}.tar.gz && \
  rm -rf gh_${GH_VERSION}_linux_${ARCH}


# hugo - https://github.com/gohugoio/hugo/releases
RUN curl -LO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${ARCH}.tar.gz" && \
  tar -zxvf hugo_${HUGO_VERSION}_linux-${ARCH}.tar.gz && \
  mv hugo /usr/local/bin/hugo && \
  rm hugo_${HUGO_VERSION}_linux-${ARCH}.tar.gz LICENSE README.md

RUN echo '\nalias docker_sock="sudo setfacl -m u:dev:rw /var/run/docker.sock"'>> /home/dev/.bashrc
RUN echo '\nalias k="kubectl"'>> /home/dev/.bashrc
# RUN echo '\nalias one_pass="eval $(op signin)"'>> /home/dev/.bashrc

USER dev

RUN mkdir -p /home/dev/.config/op

WORKDIR /home/dev