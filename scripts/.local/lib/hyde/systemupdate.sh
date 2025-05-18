#!/usr/bin/env bash

# Check release
if [ ! -f /etc/arch-release ] ; then
    exit 0
fi

# source variables
scrDir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1091
source "$scrDir/globalcontrol.sh"
get_aurhlpr
export -f pkg_installed
mkdir -p "$HYDE_RUNTIME_DIR"
temp_file="$HYDE_RUNTIME_DIR/update_info"
# shellcheck source=/dev/null
[ -f "$temp_file" ] && source "$temp_file"

# Trigger upgrade
if [ "$1" == "up" ] ; then
    if [ -f "$temp_file" ]; then
        # refreshes the module so after you update it will reset to zero
        trap 'pkill -RTMIN+20 waybar' EXIT
        # Read info from env file
        while IFS="=" read -r key value; do
            case "$key" in
                OFFICIAL_UPDATES) official=$value ;;
                AUR_UPDATES) aur=$value ;;
            esac
        done < "$temp_file"

        command="
        fastfetch.sh
        printf '[Official] %-10s\n[AUR]      %-10s\n' '$official' '$aur'
        ${aurhlpr} -Syu
        read -n 1 -p 'Press any key to continue...'
        "
        kitty --title systemupdate sh -c "${command}"
    else
        echo "No upgrade info found. Please run the script without parameters first."
    fi
    exit 0
fi

# Check for AUR updates
aur=$(${aurhlpr} -Qua | wc -l) 
ofc=$(CHECKUPDATES_DB=$(mktemp -u) checkupdates | wc -l)

# Calculate total available updates
upd=$(( ofc + aur ))
# Prepare the upgrade info
upgrade_info=$(cat <<EOF
OFFICIAL_UPDATES=$ofc
AUR_UPDATES=$aur
EOF
)

# Save the upgrade info
echo "$upgrade_info" > "$temp_file"
# Show tooltip
if [ $upd -eq 0 ] ; then
    upd="" #Remove Icon completely
    # upd="󰮯"   #If zero Display Icon only
    echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
else
    echo "{\"text\":\"󰮯 $upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur\"}"
fi
