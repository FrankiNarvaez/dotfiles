#!/usr/bin/env bash
# Simplified wallpaper selection and setting script

# Set wallpaper directory
WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"

# Show help message
show_help() {
  cat <<EOF
Usage: $(basename "$0") [options]
options:
  -S, --select      Select wallpaper using rofi
  -s, --set <file>  Set specified wallpaper
  -c, --current     Set the saved wallpaper
  -h, --help        Display this help message
EOF
  exit 0
}

# Select wallpaper using rofi
wallpaper_select() {
  # Rofi configuration
  font_name="JetBrainsMono Nerd Font"
  font_scale=10
  font_override="* {font: \"${font_name} ${font_scale}\";}"

  # Get monitor details
  mon_data=$(hyprctl -j monitors)
  mon_x_res=$(jq '.[] | select(.focused==true) | if (.transform % 2 == 0) then .width else .height end' <<<"${mon_data}")
  mon_scale=$(jq '.[] | select(.focused==true) | .scale' <<<"${mon_data}" | sed "s/\.//")
  mon_x_res=$((mon_x_res * 100 / mon_scale))

  # Calculate rofi layout
  elm_width=$(((28 + 8 + 5) * font_scale))
  max_avail=$((mon_x_res - (4 * font_scale)))
  col_count=$((max_avail / elm_width))

  r_override="window{width:100%;}
  listview{columns:${col_count};spacing:5em;}
  element{border-radius:20px;orientation:vertical;} 
  element-icon{size:28em;border-radius:0em;}
  element-text{padding:1em;}"

  # Launch rofi menu
  local entry
  entry=$(
      find "${WALLPAPER_DIR}" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | 
      sed "s|^${WALLPAPER_DIR}/||" | 
      awk '{print $0 ":::" "'${WALLPAPER_DIR}'/" $0 ":::" "'${WALLPAPER_DIR}'/" $0 "\u0000icon\u001f'${WALLPAPER_DIR}'/" $0}' | 
      rofi -dmenu \
          -display-column-separator ":::" \
          -display-columns 1 \
          -theme-str "${font_override}" \
          -theme-str "${r_override}" \
          -theme "selector"
  )
  
  selected_wallpaper_path=$(awk -F ':::' '{print $2}' <<<"${entry}")
  
  if [ -z "${selected_wallpaper_path}" ]; then
      echo "No wallpaper selected"
      exit 1
  fi
  
  # Set the wallpaper
  set_wallpaper "${selected_wallpaper_path}"
}

# Set wallpaper function
set_wallpaper() {
  local wallpaper_path="$1"

  # Ensure the wallpaper exists
  if [ ! -f "${wallpaper_path}" ]; then
    echo "Wallpaper not found: ${wallpaper_path}"
    exit 1
  fi

  # Init swww-daemon
  if ! swww query &>/dev/null; then
    swww-daemon --format xrgb & disown
    # esperar a que el daemon levante
    while ! swww query &>/dev/null; do sleep 0.1; done
  fi

  # Get color pallete
  wal -n -q -i "${wallpaper_path}"

  # Use swww to set the wallpaper
  swww img "${wallpaper_path}" \
    --transition-type grow \
    --transition-duration 0.6 \
    --invert-y \
    --transition-fps 60 \
    --transition-pos "$(hyprctl cursorpos 2>/dev/null || echo "0,0")"

  current_wallpaper "${wallpaper_path}"

  # Notify about wallpaper change
  notify-send -a "Wallpaper" "Wallpaper changed" -i "${wallpaper_path}"

  # Reload waybar to apply colors
  waybar.sh -L
}

current_wallpaper() {
  cache_dir="$HOME/.cache/wallpaper"
  link_path="$cache_dir/wallpaper_selected"

  # asegúrate de que exista el directorio
  mkdir -p "$cache_dir"

  if [[ -n "$1" ]]; then
    # si nos pasan un parámetro, creamos (o sobreescribimos) el symlink
    src="$1"
    ln -sf "$src" "$link_path"
  else
    # si no nos pasan nada, leemos hacia dónde apunta el symlink
    if [[ -L "$link_path" ]]; then
      target="$(readlink "$link_path")"
      set_wallpaper "$target"
    else
      echo "No hay wallpaper seleccionado (falta el enlace)." >&2
      return 1
    fi
  fi
}

# Main script logic
main() {
  # Check if no arguments are provided
  if [ -z "${*}" ]; then
    show_help
  fi

  # Parse options
  case "$1" in
    -S|--select)
      wallpaper_select
      shift
      ;;
    -s|--set)
      if [ -z "$2" ]; then
        echo "Error: No wallpaper path provided"
        exit 1
      fi
      set_wallpaper "$2"
      shift 2
      ;;
    -c|--current)
      current_wallpaper
      shift 2
      ;;
    -h|--help)
      show_help
      ;;
    *)
      echo "Invalid option: $1"
      show_help
      ;;
  esac
}

# Run the main function
main "$@"
