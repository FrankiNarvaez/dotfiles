#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/waybar/themes"
CACHE_TOGGLE="$HOME/.cache/waybar/waybar-disabled"
ROFI_THEME="windows"

toggle() {
  [[ -f "$CACHE_TOGGLE" ]] && rm "$CACHE_TOGGLE" || touch "$CACHE_TOGGLE"
  launch
}

kill_waybar() { pkill -x waybar 2>/dev/null; }

launch() {
  # If Waybar is disabled, kill every instance and exit
  if [[ -f "$CACHE_TOGGLE" ]]; then
    kill_waybar
    exit 0
  fi

  kill_waybar; sleep 0.15   # ensure a single instance

  local theme="${1:-$(current_theme)}"

  waybar \
    -c "$THEMES_DIR/$theme/config.jsonc" \
    -s "$THEMES_DIR/$theme/style.css" &

  echo "$theme" > "$HOME/.cache/waybar.set"
}

current_theme() {
  local cache="$HOME/.cache/waybar.set"
  [[ -f "$cache" ]] && cat "$cache" || echo hyde
}

theme_select() {
  # Get list of sub-directories (themes)
  mapfile -t themes < <(find "$THEMES_DIR" -maxdepth 1 -type d -printf '%f\n' | tail -n +2)

  # Build Rofi list; if preview.png exists, use it as an icon
  local list=""
  for t in "${themes[@]}"; do
    if [[ -f "$THEMES_DIR/$t/preview.png" ]]; then
      list+="$t\0icon\x1f$THEMES_DIR/$t/preview.png\n"
    else
      list+="$t\n"
    fi
  done

  local chosen
  chosen=$(printf '%b' "$list" | rofi -dmenu -i \
            -p "Waybar theme:" \
            -theme "$ROFI_THEME")
  [[ -n $chosen ]] && launch "$chosen"
}

show_help() {
cat <<EOF
Usage: $(basename "$0") [option]
  -T | --toggle           Enable / disable Waybar
  -S | --select           Open Rofi menu to choose a theme
  -s | --set <theme>      Launch Waybar with <theme>
  -L | --launch           Relaunch Waybar with the last used theme
  -h | --help             Show this help
EOF
exit
}

main() {
  [[ -z $1 ]] && show_help
  case $1 in
    -T|--toggle)  toggle ;;
    -S|--select)  theme_select ;;
    -s|--set)     [[ -z $2 ]] && { echo "Theme name expected"; exit 1; }; launch "$2" ;;
    -L|--launch)  launch ;;
    -h|--help|*)  show_help ;;
  esac
}

main "$@"
