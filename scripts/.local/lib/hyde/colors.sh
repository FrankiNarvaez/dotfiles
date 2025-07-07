#!/bin/bash
SPICETIFY_THEMES_DIR="$HOME/.config/spicetify/Themes"
THEME="Ziro"
COLOR_SCHEME="Wal"

# Read pywal colors
source "$HOME/.cache/wal/colors.sh"

# Create color.ini with pywal colors mapped to new properties
cat >"$SPICETIFY_THEMES_DIR/$THEME/color.ini" <<EOF
[Wal]
text               = ${foreground#\#}
subtext            = ${color7#\#}
main               = ${background#\#}
sidebar            = ${background#\#}
player             = ${background#\#}
card               = ${color0#\#}
shadow             = ${color0#\#}
selected-row       = ${color6#\#}
button             = ${color6#\#}
button-active      = ${color14#\#}
button-disabled    = ${color8#\#}
tab-active         = ${color6#\#}
notification       = ${color0#\#}
notification-error = ${color1#\#}
misc               = ${background#\#}
EOF

# Apply spicetify theme
spicetify config current_theme $THEME
spicetify config color_scheme $COLOR_SCHEME
spicetify apply
