#!/bin/bash

set -ouex pipefail

echo "::group:: ===== Populate Image Info ====="
/ctx/build_files/00-image-info.sh
echo "::endgroup::"

echo "::group:: ===== Manage Packages ====="
/ctx/build_files/01-packages.sh
/ctx/build_files/02-icons.sh
install -Dm0644 -t /etc/ublue-os/ /ctx/iso_files/*.list # ujust install-system-flatpaks
echo "::endgroup::"

echo "::group:: ===== Manage Configurations ====="
/ctx/build_files/10-flatpak-librewolf.sh
rsync -rvK /ctx/system_files/ /
echo "::endgroup::"

echo "::group:: ===== Include Justfiles ====="
/ctx/build_files/20-just.sh
echo "::endgroup::"

echo "::group:: ===== Finalize ====="
/ctx/build_files/99-finalize.sh
echo "::endgroup::"