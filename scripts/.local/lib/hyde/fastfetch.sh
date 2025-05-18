#!/usr/bin/env bash

# Varibles
CONFIG_DIG="$HOME/.config/fastfetch"
LOGOS_DIR="${CONFIG_DIG}/logos"
PRESETS_DIR="${CONFIG_DIG}/presets"
CACHE_DIR="$HOME/.cache/fastfetch/"
image_dirs=()

# shellcheck source=/dev/null
[ -f "$HYDE_STATE_HOME/staterc" ] && source "$HYDE_STATE_HOME/staterc"
[ -f "/etc/os-release" ] && source "/etc/os-release"

launch() {
  local logo_path=$(random_logo)
  local config="${1:-$(current_config)}"

  [[ -z $logo_path ]] && { echo "No logo found in ${LOGOS_DIR}"; exit 1; }
  exec fastfetch --config "${PRESETS_DIR}/$config.jsonc" --kitty "$logo_path" --logo-width 32
}

set_default_config() {
  if [[ -n "$1" ]]; then
    echo "$1" > "${CACHE_DIR}/fast.set"
    launch "$1"
  fi
}

# Get current config
current_config() {
  local cache="${CACHE_DIR}/fast.set"
  [[ -f "$cache" ]] && cat "$cache" || echo "14"
}

# Get random logo
random_logo() {
  find -L "${LOGOS_DIR}" -maxdepth 1 -type f \
       \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \
          -o -iname "*.ico" -o -iname "*.icns" -o -iname "*logo*" \) \
       2>/dev/null | shuf -n 1
}

get_configs() {
  find -L "${PRESETS_DIR}" -maxdepth 1 -type f \
    \( -iname "*.jsonc" -o -iname "*.jscon" \) \
    2>/dev/null
}

show_configs() {
  [[ -z "$1" ]] && show_help

  configs=$(get_configs)

  if [[ "list" = "$1" ]]; then
    echo "Config names:"
    for c in $configs; do
      echo "  $(basename $c)"
    done
  elif [[ "preview" = "$1" ]]; then
    for c in $configs; do
      echo -e "\n$(basename $c)::\n"
      fastfetch --config "${c}"
    done
  fi
}

show_help() {
cat <<EOF
Usage: $(basename "$0") [option]
  -r | --random           Show with a random logo
  -c | --config <name>    Launch fastfetch with <name>  (whitout .jsonc | .json)
  -s | --set <name>       Set default theme with <name> (whitout .jsonc | .json)
  -S | --show [option]
    list                Show config names
    preview             Preview aviables configs
  -h | --help             Show this help
EOF
exit
}

main() {
  [[ -z $1 ]] && launch
  case $1 in
    -h| --help)
      show_help
      ;;
    -r | --random)
      launch
      ;;
    -c | --config)
      launch "$2"
      ;;
    -s | --set)
      set_default_config "$2"
      ;;
    -S | --show)
      show_configs "$2"
      ;;
    *)
      show_help
      ;;
  esac
}

main "$@"
