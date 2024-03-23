# Development Environment

## Intent
Containerized development tooling that can integrate with a minimal amount of host-installed dependencies. For instance, the `dev-container` workflow for vscode integrating and handling git credentials is a nice mechanism for not needing to copy credentials into the container or multiple places.

## Requirements
1. Replicate everyday development tooling to a container
2. amd64 and arm64 support for the primary development container
3. Compose file for development server - hosting multiple services

## Tooling
TabbyML for coding assistant capabilities

## Host Machine Setup

### Tabby Requirements
- [Nvidia Container Toolkit install](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt)
- [Nvidia Container Toolkit Docker Steps](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-docker)
- [Nvidia Driver Installation](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local)
