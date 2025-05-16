#!/usr/bin/env bash

# Ruta al archivo JSON generado por wal
WAL_COLORS="$HOME/.cache/wal/colors.json"
OUTPUT_ROFI="$HOME/.config/rofi/colors.rasi"
OUTPUT_HYPR="$HOME/.config/hypr/colors.conf"

# Extraer colores usando jq
bg=$(jq -r '.special.background' "$WAL_COLORS")
fg=$(jq -r '.special.foreground' "$WAL_COLORS")
cursor=$(jq -r '.special.cursor' "$WAL_COLORS")

color0=$(jq -r '.colors.color0' "$WAL_COLORS")
color1=$(jq -r '.colors.color1' "$WAL_COLORS")
color2=$(jq -r '.colors.color2' "$WAL_COLORS")
color3=$(jq -r '.colors.color3' "$WAL_COLORS")
color4=$(jq -r '.colors.color4' "$WAL_COLORS")
color5=$(jq -r '.colors.color5' "$WAL_COLORS")
color6=$(jq -r '.colors.color6' "$WAL_COLORS")
color7=$(jq -r '.colors.color7' "$WAL_COLORS")
color8=$(jq -r '.colors.color8' "$WAL_COLORS")
color9=$(jq -r '.colors.color9' "$WAL_COLORS")
color10=$(jq -r '.colors.color10' "$WAL_COLORS")
color11=$(jq -r '.colors.color11' "$WAL_COLORS")
color12=$(jq -r '.colors.color12' "$WAL_COLORS")
color13=$(jq -r '.colors.color13' "$WAL_COLORS")
color14=$(jq -r '.colors.color14' "$WAL_COLORS")
color15=$(jq -r '.colors.color15' "$WAL_COLORS")

# Generar archivo .rasi para Rofi
cat > "$OUTPUT_ROFI" <<EOF
* {
    main-bg:    ${bg}cc;
    main-fg:    ${fg}e6;
    main-br:    ${color1}e6;
    main-ex:    ${color2}e6;
    select-bg:  ${color4}80;
    select-fg:  ${color6}e6;
}
EOF

# Generar archivo de colores para Hyprland
cat > "$OUTPUT_HYPR" <<EOF
\$background = $bg
\$foreground = $fg
\$color0 = $color0
\$color1 = $color1
\$color2 = $color2
\$color3 = $color3
\$color4 = $color4
\$color5 = $color5
\$color6 = $color6
\$color7 = $color7
\$color8 = $color8
\$color9 = $color9
\$color10 = $color10
\$color11 = $color11
\$color12 = $color12
\$color13 = $color13
\$color14 = $color14
\$color15 = $color15
EOF

echo "Archivos generados:"
echo "→ Rofi: $OUTPUT_ROFI"
echo "→ Hyprland: $OUTPUT_HYPR"
