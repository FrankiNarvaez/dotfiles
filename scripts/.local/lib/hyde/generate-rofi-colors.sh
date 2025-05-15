#!/usr/bin/env bash

# Ruta al archivo JSON generado por wal
WAL_COLORS="$HOME/.cache/wal/colors.json"
OUTPUT="$HOME/.config/rofi/colors.rasi"

# Extraer colores usando jq
bg=$(jq -r '.special.background' "$WAL_COLORS")
fg=$(jq -r '.special.foreground' "$WAL_COLORS")
color1=$(jq -r '.colors.color1' "$WAL_COLORS")
color2=$(jq -r '.colors.color2' "$WAL_COLORS")
color4=$(jq -r '.colors.color4' "$WAL_COLORS")
color6=$(jq -r '.colors.color6' "$WAL_COLORS")

# Generar archivo .rasi
cat > "$OUTPUT" <<EOF
* {
    main-bg:    ${bg}cc;
    main-fg:    ${fg}e6;
    main-br:    ${color1}e6;
    main-ex:    ${color2}e6;
    select-bg:  ${color4}80;
    select-fg:  ${color6}e6;
}
EOF

echo "Archivo generado en: $OUTPUT"

