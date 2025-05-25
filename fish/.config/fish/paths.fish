# ██████╗  █████╗ ████████╗██╗  ██╗███████╗
# ██╔══██╗██╔══██╗╚══██╔══╝██║  ██║██╔════╝
# ██████╔╝███████║   ██║   ███████║███████╗
# ██╔═══╝ ██╔══██║   ██║   ██╔══██║╚════██║
# ██║     ██║  ██║   ██║   ██║  ██║███████║
# ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝

# Brew path
# set BREW_BIN /home/linuxbrew/.linuxbrew/bin/brew
# eval ($BREW_BIN shellenv)

# Bun path
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

# Spicetify path
fish_add_path /home/frann/.spicetify

# Php and Laravel
set -x PATH /home/frann/.config/herd-lite/bin $PATH
set -x PHP_INI_SCAN_DIR /home/frann/.config/herd-lite/bin $PHP_INI_SCAN_DIR
