# Global build variables
ARG IMAGE_NAME="${IMAGE_NAME:-bluefin}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-coxde}"
ARG BASE_IMAGE_DIGEST="${BASE_IMAGE_DIGEST}"

# Stage 1: Build context
FROM scratch AS ctx
COPY /build_files /build_files
COPY /iso_files /iso_files

# Stage 2: Base image
FROM ghcr.io/ublue-os/bluefin-dx:stable${BASE_IMAGE_DIGEST:+@${BASE_IMAGE_DIGEST}}

# Use variables in this stage
ARG IMAGE_NAME
ARG IMAGE_VENDOR

# Build
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_files/build.sh && \
    ostree container commit

# Linting
RUN bootc container lint
