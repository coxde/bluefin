# Bluefin 💙

[![Build Image](https://github.com/coxde/bluefin/actions/workflows/build.yml/badge.svg)](https://github.com/coxde/bluefin/actions/workflows/build.yml)

## Purpose 🤔

This repository is for my personal OS image, very much based on my own needs. It's based on [Bluefin (dx-stable)](https://github.com/ublue-os/bluefin/) and a template published by the [Universal Blue](https://universal-blue.org/) Project.

## Features ✨

-   Extra [packages](https://github.com/coxde/bluefin/blob/main/build_files/01-packages.sh)
-   More [Justfiles](https://github.com/coxde/bluefin/tree/main/build_files/20-just.sh)
-   More Icons
-   LibreWolf tweaks

## Installation ⚙️

### Rebase

To rebase an existing Bluefin installation to this build:

-   Rebase to the latest image:

    ```
    sudo bootc switch ghcr.io/coxde/bluefin:latest --enforce-container-sigpolicy
    ```

    -   The `--enforce-container-sigpolicy` is important to ensure you're checking the signature of the produced image.

-   Reboot to complete the rebase:
    ```
    systemctl reboot
    ```

The `latest` tag will automatically point to the latest build.

### ISO

Anaconda WebUI Live ISO: https://github.com/coxde/bluefin/actions/workflows/build-iso-live.yml

## Verification ✅

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/coxde/bluefin
```

## Credits 💌

-   [Universal Blue](https://universal-blue.org/)
-   [BlueBuild](https://blue-build.org/)
-   [Aurora](https://getaurora.dev/)
-   [Bazzite](https://bazzite.gg/)
-   [Bluefin](https://projectbluefin.io/)
-   [m2os](https://github.com/m2giles/m2os)
