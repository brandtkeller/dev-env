#!/bin/bash

# Ensure we are in the correct directory

cd /home/dev/repos/dev-env/

# Pull latest changes from git
echo "Pulling latest changes from git"
git pull

# Stop existing services
echo "Stopping existing services"
docker compose --project-directory compose/ down

# Prune images
echo "Pruning docker images to prevent cache"
docker image prune -a -f

# Rebuild images
echo "Rebuilding container images"
./build.sh amd64

# Start new services
echo "Starting new services"
docker compose --project-directory compose/ up go-dev node-dev registry -d
