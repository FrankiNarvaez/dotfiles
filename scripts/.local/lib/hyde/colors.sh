#!/bin/bash

SPICETIFY_THEMES_DIR="$HOME/.config/spicetify/Themes"
THEME="text"
COLOR_SCHEME="Kanagawa"

# Read pywal colors
source "$HOME/.cache/wal/colors.sh"

# Create color with color.ini
cat >"$SPICETIFY_THEMES_DIR/$THEME/color.ini" <<EOF
[Kanagawa]
accent             = ${color6#\#}
accent-active      = ${color14#\#}
accent-inactive    = ${background#\#}
banner             = ${color6#\#}
border-active      = ${color6#\#}
border-inactive    = ${color8#\#}
header             = ${color8#\#}
highlight          = ${color0#\#}
main               = ${background#\#}
notification       = ${color4#\#}
notification-error = ${color1#\#}
subtext            = ${color7#\#}
text               = ${foreground#\#}
EOF

# Apply spicetify theme
spicetify config current_theme $THEME
spicetify config color_scheme $COLOR_SCHEME
spicetify apply
