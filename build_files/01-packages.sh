#!/bin/bash

set -ouex pipefail

# Install packages
dnf5 -y install \
    pipx \
    podlet \
    syncthing

# Install packages from terra
dnf5 -y install --enable-repo="terra" \
    ghostty

# Install COPR packages
dnf5 -y copr enable bazzite-org/webapp-manager
dnf5 -y install webapp-manager
dnf5 -y copr disable bazzite-org/webapp-manager

# Install 3rd party packages
### Collision nautilus extension
curl --retry 3 --create-dirs -Lo /etc/skel/.local/share/nautilus-python/extensions/collision-extension.py https://github.com/GeopJr/Collision/raw/refs/heads/main/nautilus-extension/collision-extension.py

# Remove packages
dnf5 -y remove \
    code \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin
