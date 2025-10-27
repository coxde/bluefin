# Install gaming related flatpaks
[group('Apps')]
install-yet-another-gaming-flatpaks ACTION="":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh
    OPTION={{ ACTION }}

    if [ "$OPTION" == "" ]; then
        echo "${bold}Install gaming related flatpaks${normal}"
        OPTION=$(Choose "Install")
    fi

    if [[ "${OPTION,,}" =~ ^install ]]; then
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak --system -y install --or-update \
            app/com.github.Matoking.protontricks/x86_64/stable \
            app/com.heroicgameslauncher.hgl/x86_64/stable \
            app/page.kramo.Cartridges/x86_64/stable \
            app/com.valvesoftware.Steam/x86_64/stable \
            app/io.github.Foldex.AdwSteamGtk/x86_64/stable \
            app/org.prismlauncher.PrismLauncher/x86_64/stable \
            runtime/com.obsproject.Studio.Plugin.OBSVkCapture/x86_64/stable \
            runtime/com.valvesoftware.Steam.CompatibilityTool.Proton-GE/x86_64/stable \
            runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08 \
            runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
            runtime/org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/23.08
    fi
