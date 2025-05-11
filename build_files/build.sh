#!/bin/bash

set -ouex pipefail

echo "::group:: ===== Manage Packages ====="
/ctx/build_files/packages.sh
install -Dm0644 -t /etc/ublue-os/ /ctx/iso_files/*.list # ujust install-system-flatpaks
echo "::endgroup::"

echo "::group:: ===== Run Scripts ====="
/ctx/build_files/flatpak-librewolf.sh
rsync -rvK /ctx/system_files/ /
echo "::endgroup::"

echo "::group:: ===== Install Themes ====="
/ctx/build_files/icons.sh
echo "::endgroup::"

echo "::group:: ===== Include Just Recipes ====="
/ctx/build_files/just.sh
echo "::endgroup::"

echo "::group:: ===== Replace Image Info ====="
/ctx/build_files/image-info.sh
echo "::endgroup::"

echo "::group:: ===== Finalize ====="
/ctx/build_files/finalize.sh
echo "::endgroup::"