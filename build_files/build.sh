#!/bin/bash

set -ouex pipefail

echo "::group:: ===== Manage Packages ====="
/ctx/packages.sh
echo "::endgroup::"

echo "::group:: ===== Run Scripts ====="
/ctx/flatpak-librewolf.sh
echo "::endgroup::"

echo "::group:: ===== Install Themes ====="
/ctx/icons.sh
echo "::endgroup::"

echo "::group:: ===== Include Just Recipes ====="
/ctx/just.sh
echo "::endgroup::"

echo "::group:: ===== Replace Image Info ====="
/ctx/image-info.sh
echo "::endgroup::"

echo "::group:: ===== Finalize ====="
/ctx/finalize.sh
echo "::endgroup::"