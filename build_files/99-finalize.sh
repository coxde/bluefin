#!/bin/bash

set -ouex pipefail

# Remove VS Code leftover
rm -f /usr/share/ublue-os/user-setup.hooks.d/10-vscode.sh
rm -rf /etc/skel/.config/Code/

# Disable Fedora telemetry
# https://docs.projectbluefin.io/analytics/#fedora
systemctl mask rpm-ostree-countme.timer

# Disable connectivity check
# https://www.ctrl.blog/entry/network-connection-http-checks.html
# https://wiki.archlinux.org/title/NetworkManager#Checking_connectivity
tee /etc/NetworkManager/conf.d/20-connectivity.conf <<EOF
[connectivity]
enabled=false
EOF

# Disable Tailscale telemetry
>> /etc/default/tailscaled  <<EOF
TS_NO_LOGS_NO_SUPPORT=true
EOF

# Clean temp files
# https://github.com/ublue-os/bluefin/blob/main/build_files/shared/build-dx.sh
dnf5 clean all

rm -rf /tmp/* || true
find /var/* -maxdepth 0 -type d \! -name cache -exec rm -fr {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 \! -name rpm-ostree -exec rm -fr {} \;

mkdir -p /var/tmp
chmod -R 1777 /var/tmp