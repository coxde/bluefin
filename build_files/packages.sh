#!/bin/bash

set -ouex pipefail

# Install packages
dnf5 -y install \
    gnome-shell-extension-vertical-workspaces \
    pipx \
    podlet \
    syncthing

# Install COPR packages

# Install 3rd party packages

# Remove packages