#!/bin/bash

eval $(op signin)

op read op://Employee/development/.gitconfig >> /home/dev/.gitconfig

mkdir -p /home/dev/.ssh
op read op://Employee/development/id_ed25519 >> /home/dev/.ssh/id_ed25519
op read op://Employee/development/id_ed25519.pub >> /home/dev/.ssh/id_ed25519.pub
op read op://Employee/development/id_rsa >> /home/dev/.ssh/id_rsa
op read op://Employee/development/id_rsa.pub >> /home/dev/.ssh/id_rsa.pub

chmod 600 /home/dev/.ssh/id_rsa /home/dev/.ssh/id_ed25519