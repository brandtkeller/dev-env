# Development Environment

This repository captures my development environment comprised of containerized tools. The experiment here is to drive some discomfort around waht data persists and what tooling is available such that I can continually remove unnecessary tools from my 

## Intent
Containerized development tooling that can integrate with a minimal amount of host-installed dependencies. For instance, the `dev-container` workflow for vscode integrating and handling git credentials is a nice mechanism for not needing to copy credentials into the container or multiple places.

## Comfort in Discomfort
In order to continue to iterate on this idea - I want to perform a nuke of any existing containers on a periodic basis (weekly minimum). 
For my compose-managed environments (remote-ssh) I'll want to `docker compose down dev-container`.
Once done a `docker image prune -af` should remove all remaining images.

## Requirements
1. Replicate everyday development tooling to a container
2. amd64 and arm64 support for the primary development container
3. Compose file for development server - hosting multiple services

## Host Machine Requirements
- Docker Server (Colima on Mac/ Docker on Ubuntu)

## Tooling
TabbyML for coding assistant capabilities


### Tabby Requirements
- [Nvidia Container Toolkit install](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt)
- [Nvidia Container Toolkit Docker Steps](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-docker)
- [Nvidia Driver Installation](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local)

## TODO
- Think about a weekly nuke script
- Setup ohmyzsh and customize/personalize
- Setup renovate to monitor and update dependencies
- Improve the build workflow
- Potentially push images to registry