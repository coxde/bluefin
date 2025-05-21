#!/bin/bash

set -ouex pipefail

# Set variables
IMAGE_INFO_FILE="/usr/share/ublue-os/image-info.json"
IMAGE_REF="ostree-image-signed:docker://ghcr.io/$IMAGE_VENDOR/$IMAGE_NAME"

# Replace image info
sed -i \
    -e 's|"image-name": ".*"|"image-name": "'"$IMAGE_NAME"'"|' \
    -e 's|"image-vendor": ".*"|"image-vendor": "'"$IMAGE_VENDOR"'"|' \
    -e 's|"image-ref": ".*"|"image-ref": "'"$IMAGE_REF"'"|' \
    -e 's|"image-tag":.*"|"image-tag": "'"$IMAGE_TAG"'"|' \
    "$IMAGE_INFO_FILE"
