#!/bin/bash

set -ouex pipefail

# Install packages
dnf5 -y install \
    pipx \
    podlet \
    syncthing

# Install COPR packages

# Install 3rd party packages

# Remove packages
dnf5 -y remove \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin