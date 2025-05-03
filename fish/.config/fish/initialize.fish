# ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗███████╗
# ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔════╝
# ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ █████╗  
# ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══╝  
# ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗███████╗
# ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚══════╝

# Init starship
# starship init fish | source

# Init atuin
# atuin init fish | source

# Set tmux
# if not set -q TMUX
#     tmux
# end

# Set zellij
# if not set -q ZELLIJ
#     zellij
# end

# Set default editor
set -x EDITOR nvim

# Set project path to use with "pj"
set -gx PROJECT_PATHS ~/Development
