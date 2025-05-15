#!/bin/bash

# Float term with power menu
show_menu() {
  echo "  1. Poweroff"
  echo "  2. Reboot"
  echo "  3. Suspend"
  echo "  4. Close session"
  echo "  5. Cancel"
  echo -e "\n  Select an option [1-5]: "
  read -n 1 option

  case $option in
    1) systemctl poweroff ;;
    2) systemctl reboot ;;
    3) systemctl suspend ;;
    4) hyprctl dispatch exit ;;
    5|$'\e') exit 0 ;;
    *) 
      echo -e "\n\n  Invalid option. Press any key."
      read -n 1
      exit 1
      ;;
  esac
}

# Launch
kitty --class=foot-float -e bash -c "$(declare -f show_menu); show_menu"
