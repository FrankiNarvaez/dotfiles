#!/usr/bin/env bash

#  _____                 _       __        __          _                
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __ 
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |   
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|   
#            |___/ |___/                         |___/                  
#

toggle() {
  if [ -f ~/.cache/waybar-disabled ] ;then
    rm ~/.cache/waybar-disabled
  else
    touch ~/.cache/waybar-disabled
  fi
  launch
}

#  ____  _             _    __        __          _                 
# / ___|| |_ __ _ _ __| |_  \ \      / /_ _ _   _| |__   __ _ _ __  
# \___ \| __/ _` | '__| __|  \ \ /\ / / _` | | | | '_ \ / _` | '__| 
#  ___) | || (_| | |  | |_    \ V  V / (_| | |_| | |_) | (_| | |    
# |____/ \__\__,_|_|   \__|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|    
#                                           |___/                   
# ----------------------------------------------------- 

launch() {
  # Check if waybar-disabled file exists
  if [ -f $HOME/.cache/waybar-disabled ] ;then 
    killall waybar
    pkill waybar
    exit 1 
  fi

  # ----------------------------------------------------- 
  # Quit all running waybar instances
  # ----------------------------------------------------- 
  killall waybar
  pkill waybar
  sleep 0.2

  # ----------------------------------------------------- 
  # Default theme: /THEMEFOLDER;/VARIATION
  # ----------------------------------------------------- 
  themestyle="/${1:-hyde}"

  # ----------------------------------------------------- 
  # Loading the configuration
  # ----------------------------------------------------- 
  waybar -c ~/.config/waybar/themes${themestyle}/config.jsonc -s ~/.config/waybar/themes${themestyle}/style.css &
}

show_help() {
  echo "En desarrollo"
  exit
}

# Main script logic
main() {
  # Check if no arguments are provided
  if [ -z "${*}" ]; then
    show_help
  fi

  # Parse options
  case "$1" in
    -T|--toggle)
      toggle
      shift
      ;;
    -S|--set)
      if [ -z "$2" ]; then
        echo "Error: No name theme provided"
        exit 1
      fi
      launch "$2"
      shift 2
      ;;
    -L|--launch)
      launch
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
