# -----------------------------------------
# dev-container base
# -----------------------------------------
ARG TAG="latest"
FROM dev-base:$TAG

ARG ARCH="amd64"
ARG ALT_ARCH="x86_64"

# -----------------------------------------
# tool versions (prefixed to avoid Viper)
# -----------------------------------------
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
ARG DEVENV_KUBE_VERSION="v1.34.0"
# helm - https://github.com/helm/helm/releases  
ARG DEVENV_HELM_VERSION="v3.18.6"
# oras - https://github.com/oras-project/oras/releases
ARG DEVENV_ORAS_VERSION="1.3.0"
# Kind - https://github.com/kubernetes-sigs/kind/releases
ARG DEVENV_KIND_VERSION="v0.30.0"
# Docker CLI - https://download.docker.com/linux/static/stable
ARG DEVENV_DOCKER_VERSION="28.4.0"
# Docker Buildx -  https://github.com/docker/buildx/releases
ARG DEVENV_DOCKER_BUILDX_VERSION="v0.28.0"
# K3d - https://github.com/k3d-io/k3d/releases
ARG DEVENV_K3D_VERSION="v5.8.3"
# 1password CLI - https://developer.1password.com/docs/cli/get-started/
ARG DEVENV_OP_VERSION="v2.32.0"
# UDS-CLI - https://github.com/defenseunicorns/uds-cli/releases
ARG DEVENV_UDS_VERSION="v0.27.13"
# Zarf - https://github.com/zarf-dev/zarf/releases
ARG DEVENV_ZARF_VERSION="v0.61.2"
# Github CLI - https://github.com/cli/cli/releases
ARG DEVENV_GH_VERSION="2.79.0"
# hugo - https://github.com/gohugoio/hugo/releases
ARG DEVENV_HUGO_VERSION="0.150.0"
# cosign - https://github.com/sigstore/cosign/releases
ARG DEVENV_COSIGN_VERSION="2.5.3"

# Expose them inside the image (optional—remove if you don’t
# need access at runtime and want zero chance of collision).
ENV \
  DEVENV_KUBE_VERSION=${DEVENV_KUBE_VERSION} \
  DEVENV_HELM_VERSION=${DEVENV_HELM_VERSION} \
  DEVENV_ORAS_VERSION=${DEVENV_ORAS_VERSION} \
  DEVENV_KIND_VERSION=${DEVENV_KIND_VERSION} \
  DEVENV_DOCKER_VERSION=${DEVENV_DOCKER_VERSION} \
  DEVENV_DOCKER_BUILDX_VERSION=${DEVENV_DOCKER_BUILDX_VERSION} \
  DEVENV_K3D_VERSION=${DEVENV_K3D_VERSION} \
  DEVENV_OP_VERSION=${DEVENV_OP_VERSION} \
  DEVENV_UDS_VERSION=${DEVENV_UDS_VERSION} \
  DEVENV_ZARF_VERSION=${DEVENV_ZARF_VERSION} \
  DEVENV_GH_VERSION=${DEVENV_GH_VERSION} \
  DEVENV_HUGO_VERSION=${DEVENV_HUGO_VERSION} \
  DEVENV_COSIGN_VERSION=${DEVENV_COSIGN_VERSION}

# ----------------------------------------------------------
# package installs (each reference now uses the new names)
# ----------------------------------------------------------
USER root
WORKDIR /

RUN apt-get update && \
    apt-get install -y curl acl unzip wget rclone rsync && \
    rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -LO "https://dl.k8s.io/release/${DEVENV_KUBE_VERSION}/bin/linux/${ARCH}/kubectl" && \
    chmod +x kubectl && mv kubectl /usr/local/bin/

# helm
RUN curl -LO "https://get.helm.sh/helm-${DEVENV_HELM_VERSION}-linux-${ARCH}.tar.gz" && \
    tar -zxvf helm-${DEVENV_HELM_VERSION}-linux-${ARCH}.tar.gz && \
    mv linux-${ARCH}/helm /usr/local/bin/ && rm -rf linux-${ARCH}

# oras
RUN curl -LO "https://github.com/oras-project/oras/releases/download/v${DEVENV_ORAS_VERSION}/oras_${DEVENV_ORAS_VERSION}_linux_${ARCH}.tar.gz" && \
    tar -zxvf oras_${DEVENV_ORAS_VERSION}_linux_${ARCH}.tar.gz && \
    mv oras /usr/local/bin/

# cosign
RUN curl -LO "https://github.com/sigstore/cosign/releases/download/v${DEVENV_COSIGN_VERSION}/cosign-linux-${ARCH}" && \
    chmod +x cosign-linux-${ARCH} && mv cosign-linux-${ARCH} /usr/local/bin/cosign

# kind
RUN curl -Lo kind "https://github.com/kubernetes-sigs/kind/releases/download/${DEVENV_KIND_VERSION}/kind-linux-${ARCH}" && \
    chmod +x kind && mv kind /usr/local/bin/

# docker CLI
RUN curl -LO "https://download.docker.com/linux/static/stable/${ALT_ARCH}/docker-${DEVENV_DOCKER_VERSION}.tgz" && \
    tar -xf docker-${DEVENV_DOCKER_VERSION}.tgz && \
    mv docker/docker /usr/local/bin/ && rm -rf docker-${DEVENV_DOCKER_VERSION}.tgz docker

# docker buildx
RUN curl -LO "https://github.com/docker/buildx/releases/download/${DEVENV_DOCKER_BUILDX_VERSION}/buildx-${DEVENV_DOCKER_BUILDX_VERSION}.linux-${ARCH}" && \
    mkdir -p /home/dev/.docker/cli-plugins && \
    mv buildx-${DEVENV_DOCKER_BUILDX_VERSION}.linux-${ARCH} /home/dev/.docker/cli-plugins/docker-buildx && \
    chmod +x /home/dev/.docker/cli-plugins/docker-buildx && chown -R dev:dev /home/dev/.docker

# k3d
RUN curl -LO "https://github.com/k3d-io/k3d/releases/download/${DEVENV_K3D_VERSION}/k3d-linux-${ARCH}" && \
    chmod +x k3d-linux-${ARCH} && mv k3d-linux-${ARCH} /usr/local/bin/k3d

# 1Password CLI
RUN wget "https://cache.agilebits.com/dist/1P/op2/pkg/${DEVENV_OP_VERSION}/op_linux_${ARCH}_${DEVENV_OP_VERSION}.zip" -O op.zip && \
    unzip -d op op.zip && \
    mv op/op /usr/local/bin/ && rm -r op.zip op && \
    groupadd -f onepassword-cli && chgrp onepassword-cli /usr/local/bin/op && chmod g+s /usr/local/bin/op

# uds-cli
RUN curl -LO "https://github.com/defenseunicorns/uds-cli/releases/download/${DEVENV_UDS_VERSION}/uds-cli_${DEVENV_UDS_VERSION}_Linux_${ARCH}" && \
    chmod +x uds-cli_${DEVENV_UDS_VERSION}_Linux_${ARCH} && \
    mv uds-cli_${DEVENV_UDS_VERSION}_Linux_${ARCH} /usr/local/bin/uds

# zarf
RUN curl -LO "https://github.com/defenseunicorns/zarf/releases/download/${DEVENV_ZARF_VERSION}/zarf_${DEVENV_ZARF_VERSION}_Linux_${ARCH}" && \
    chmod +x zarf_${DEVENV_ZARF_VERSION}_Linux_${ARCH} && \
    mv zarf_${DEVENV_ZARF_VERSION}_Linux_${ARCH} /usr/local/bin/zarf

# gh CLI
RUN curl -LO "https://github.com/cli/cli/releases/download/v${DEVENV_GH_VERSION}/gh_${DEVENV_GH_VERSION}_linux_${ARCH}.tar.gz" && \
    tar -zxf gh_${DEVENV_GH_VERSION}_linux_${ARCH}.tar.gz && \
    mv gh_${DEVENV_GH_VERSION}_linux_${ARCH}/bin/gh /usr/local/bin/ && \
    rm -rf gh_${DEVENV_GH_VERSION}_linux_${ARCH}*

# hugo
RUN curl -LO "https://github.com/gohugoio/hugo/releases/download/v${DEVENV_HUGO_VERSION}/hugo_${DEVENV_HUGO_VERSION}_linux-${ARCH}.tar.gz" && \
    tar -zxvf hugo_${DEVENV_HUGO_VERSION}_linux-${ARCH}.tar.gz && \
    mv hugo /usr/local/bin/ && rm -f hugo_${DEVENV_HUGO_VERSION}_linux-${ARCH}.tar.gz LICENSE README.md

# ----------------------------------------------------------
# finish up
# ----------------------------------------------------------
RUN echo '\nalias docker_sock="sudo setfacl -m u:dev:rw /var/run/docker.sock"' >> /home/dev/.bashrc && \
    echo '\nalias k="kubectl"' >> /home/dev/.bashrc

USER dev
RUN mkdir -p /home/dev/.config/op
WORKDIR /home/dev
