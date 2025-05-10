#!/bin/bash

set -ouex pipefail

# Install packages
dnf5 -y install \
    pipx \
    podlet \
    syncthing

# Install COPR packages

# Install 3rd party packages
## Install ScopeBuddy
curl -Lo /tmp/scopebuddy.tar.gz https://github.com/HikariKnight/ScopeBuddy/archive/refs/tags/$(curl https://api.github.com/repos/HikariKnight/scopebuddy/releases/latest | jq -r '.tag_name').tar.gz
mkdir -p /tmp/scopebuddy
tar --no-same-owner --no-same-permissions --no-overwrite-dir -xvzf /tmp/scopebuddy.tar.gz -C /tmp/scopebuddy
rm -f /tmp/scopebuddy.tar.gz

for file in /tmp/scopebuddy/ScopeBuddy-*/bin/*; do
  install -Dm0755 "$file" /usr/bin/
done

# Remove packages
dnf5 -y remove \
    docker-buildx-plugin \
	docker-ce \
	docker-ce-cli \
	docker-compose-plugin