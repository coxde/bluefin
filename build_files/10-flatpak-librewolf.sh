#!/bin/bash
# Fix connection between Flatpak version LibreWolf and KeePassXC
# Add some permissions to access webcam, mic, etc.
# Credit: https://github.com/m2Giles/m2os/blob/main/flatpak.sh

set -ouex pipefail

# Enable p11-kit services
systemctl enable --global p11-kit-server.socket
systemctl enable --global p11-kit-server.service

# Create tmpfiles for KeePassXC integration
mkdir -p /usr/share/user-tmpfiles.d

tee /usr/share/user-tmpfiles.d/keepassxc-integration.conf <<EOF
C %h/.var/app/io.gitlab.librewolf-community/.librewolf/native-messaging-hosts/org.keepassxc.keepassxc_browser.json - - - - /run/keepassxc-integration/librewolf-keepassxc.json
EOF

tee /usr/lib/tmpfiles.d/keepassxc-integration.conf <<EOF
C %t/keepassxc-integration - - - - /usr/libexec/keepassxc-integration
EOF

# Create the systemd service for Flatpak overrides
tee /usr/lib/systemd/system/flatpak-librewolf-overrides.service <<EOF
[Unit]
Description=Set Overrides for LibreWolf Flatpaks
ConditionPathExists=!/etc/.%N.stamp
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/usr/libexec/flatpak-librewolf-overrides.sh
ExecStop=/usr/bin/touch /etc/.%N.stamp

[Install]
WantedBy=default.target multi-user.target
EOF

# Create the Flatpak overrides script
tee /usr/libexec/flatpak-librewolf-overrides.sh <<EOF
#!/usr/bin/bash

# LibreWolf
flatpak override \
    --system \
    --device=all \
    --allow=bluetooth \
    --filesystem=xdg-run/p11-kit/pkcs11 \
    --filesystem=/run/keepassxc-integration \
    --filesystem=/var/lib/flatpak/app/org.keepassxc.KeePassXC:ro \
    --filesystem=/var/lib/flatpak/runtime/org.kde.Platform:ro \
    --filesystem=xdg-data/flatpak/app/org.keepassxc.KeePassXC:ro \
    --filesystem=xdg-data/flatpak/runtime/org.kde.Platform:ro \
    --filesystem=xdg-run/app/org.keepassxc.KeePassXC:create \
    --env=MOZ_ENABLE_WAYLAND=1 \
    --env=MOZ_USE_XINPUT2=1 \
    io.gitlab.librewolf-community
EOF

# Make the script executable
chmod +x /usr/libexec/flatpak-librewolf-overrides.sh

# Enable the systemd service
systemctl enable flatpak-librewolf-overrides.service

# Create the KeePassXC integration directory
mkdir -p /usr/libexec/keepassxc-integration

# Create the KeePassXC proxy wrapper script
tee /usr/libexec/keepassxc-integration/keepassxc-proxy-wrapper <<'EOF'
#!/usr/bin/bash

APP_REF="org.keepassxc.KeePassXC/x86_64/stable"
for inst in "/var/lib/flatpak/" "$HOME/.local/share/flatpak/"; do
    if [ -d "$inst/app/$APP_REF" ]; then
        FLATPAK_INST="$inst"
        break
    fi
done

[ -z "$FLATPAK_INST" ] && exit 1

APP_PATH="$FLATPAK_INST/app/$APP_REF/active"
RUNTIME_REF=$(awk -F'=' '$1=="runtime" { print $2 }' < "$APP_PATH/metadata")
RUNTIME_PATH="$FLATPAK_INST/runtime/$RUNTIME_REF/active"

exec flatpak-spawn \
    --env=LD_LIBRARY_PATH="/app/lib:$APP_PATH" \
    --app-path="$APP_PATH/files" \
    --usr-path="$RUNTIME_PATH/files" \
    -- keepassxc-proxy "$@"
EOF

# Make the wrapper script executable
chmod +x /usr/libexec/keepassxc-integration/keepassxc-proxy-wrapper

# LibreWolf KeePassXC native messaging manifest
tee /usr/libexec/keepassxc-integration/librewolf-keepassxc.json <<EOF
{
    "allowed_extensions": [
        "keepassxc-browser@keepassxc.org"
    ],
    "description": "KeePassXC integration with native messaging support",
    "name": "org.keepassxc.keepassxc_browser",
    "path": "/run/keepassxc-integration/keepassxc-proxy-wrapper",
    "type": "stdio"
}
EOF