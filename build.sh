#!/bin/bash

ARCH=""
ALTARCH=""
# Rebuild the entire stack
# check for an arch parameter
if [ "$1" = "amd64" ]; then
  ARCH="amd64"
  ALTARCH="x86_64"
elif [ "$1" = "arm64" ]; then
  ARCH="arm64"
  ALTARCH="aarch64"
else
  echo "No applicable arch specified"
  exit 1
fi

DATE=$(date '+%Y%m%d')


# Build the base image
docker build -f dev-containers/base/Dockerfile -t dev-base:latest -t dev-base:$DATE .

# Build the CLI image
docker build -f dev-containers/cli/Dockerfile --build-arg TAG=$DATE --build-arg ARCH=$ARCH --build-arg ALT_ARCH=$ALTARCH -t dev-cli:latest -t dev-cli:$DATE .

# Build the golang image
docker build -f dev-containers/golang/Dockerfile --build-arg TAG=$DATE --build-arg ARCH=$ARCH --build-arg ALT_ARCH=$ALTARCH -t dev-go:latest -t dev-go:$DATE .

# Build the python image
docker build -f dev-containers/python/Dockerfile --build-arg TAG=$DATE -t dev-python:latest -t dev-python:$DATE .
