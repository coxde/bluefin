#!/bin/bash

set -ouex pipefail

# Set variables
IMPORT_FILE="/usr/share/ublue-os/just/60-custom.just"
JUST_FILES_FOLDER="/ctx/build_files/just"
DEST_FOLDER="/usr/share/ublue-os/just/custom"

# Find all justfiles
JUSTFILES=($(find "${JUST_FILES_FOLDER}" -type f -name "*.just" | sed "s|${JUST_FILES_FOLDER}/||g"))

# Copy justfiles to destination folder
mkdir -p "${DEST_FOLDER}"
cp -rfT "${JUST_FILES_FOLDER}" "${DEST_FOLDER}"

# Generate import lines for all found justfiles
for JUSTFILE in "${JUSTFILES[@]}"; do
    # Create an import line
    IMPORT_LINE="import \"${DEST_FOLDER}/${JUSTFILE}\""
        
    # Skip the import line if it already exists, else append it to import file
    if grep -wq "${IMPORT_LINE}" "${IMPORT_FILE}"; then
        echo "- Skipped: '${IMPORT_LINE}' (already present)"
    else
        echo "${IMPORT_LINE}" >> "${IMPORT_FILE}"
        echo "- Added: '${IMPORT_LINE}'"
    fi
done