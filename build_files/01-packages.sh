#!/bin/bash

set -ouex pipefail

# Install packages
dnf5 -y install \
    pipx \
    podlet \
    syncthing

# Install COPR packages
dnf5 -y copr enable bazzite-org/webapp-manager
dnf5 -y install webapp-manager
dnf5 -y copr disable bazzite-org/webapp-manager

# Install 3rd party packages

# Remove packages
dnf5 -y remove \
    code \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin