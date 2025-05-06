# Make Fish the default shell
enable-fish ACTION="":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh
    OPTION={{ ACTION }}

    if [ "$OPTION" == "help" ]; then
      echo "Usage: ujust enable-fish <option>"
      echo "  <option>: Specify the quick option to skip the prompt"
      echo "  Options:"
      echo "    enable     - Make Fish the default shell"
      echo "    reset      - Reset the default shell to bash"
      exit 0
    elif [ "$OPTION" == "" ]; then
      echo "${bold}Enable Fish${normal}"
      OPTION=$(Choose "Enable Fish" "Reset to Bash")
    fi

    if [[ "${OPTION,,}" =~ ^enable ]]; then
      sudo usermod --shell /usr/bin/fish ${USER}
    elif [[ "${OPTION,,}" =~ ^reset ]]; then
      sudo usermod --shell /usr/bin/bash ${USER}
    fi