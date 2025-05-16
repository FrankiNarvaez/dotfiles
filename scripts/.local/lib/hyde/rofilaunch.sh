#!/usr/bin/env bash

# directorio del script y control global
scrDir="$(dirname "$(realpath "$0")")"
# shellcheck source=/dev/null
. "${scrDir}/globalcontrol.sh"

# argumentos comunes para rofi
rofi_args=(
    -show-icons
)

# determina el modo según parámetro
case "$1" in
  d|--drun)
    r_mode="drun"
    ;;
  w|--window)
    r_mode="window"
    ;;
  r|--run)
    r_mode="run"
    rofi_args+=("--run-command" "sh -c 'uwsm app -- {cmd} || {cmd}'")
    ;;
  h|--help)
    echo -e "$(basename "$0") [d|w|r]"
    exit 0
    ;;
  *)
    r_mode="drun"
    ;;
esac

# solo en modo "drun" aplica el tema ~/.config/rofi/theme.rasi
if [[ "$r_mode" == "drun" ]]; then
    rofi_args+=("-theme" "$HOME/.config/rofi/themes/applications.rasi")
fi

if [[ "$r_mode" == "window" ]]; then
    rofi_args+=("-theme" "$HOME/.config/rofi/themes/windows.rasi")
fi

# lanza rofi y sale
rofi -show "$r_mode" "${rofi_args[@]}" &
disown
