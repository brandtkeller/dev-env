#!/bin/bash

# Ensure we are in the correct directory

cd /home/dev/repos/dev-env/

# Pull latest changes from git
git pull

# Stop existing services
docker compose --project-directory compose/ down

# Prune images
docker image prune -a -f

# Rebuild images
./build.sh amd64

# Start new services
docker compose --project-directory compose/ up go-dev -d

