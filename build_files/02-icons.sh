#!/bin/bash

set -ouex pipefail

# Install Papirus Icon Theme
wget -qO- https://git.io/papirus-icon-theme-install | sh

# Add Adwaita as fallback
files=(
    "/usr/share/icons/Papirus/index.theme"
    "/usr/share/icons/Papirus-Dark/index.theme"
    "/usr/share/icons/Papirus-Light/index.theme"
)

for file in "${files[@]}"; do
    sed -i "s/\(Inherits=\)/\1Adwaita,/g" "$file"
done