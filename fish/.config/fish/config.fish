if status is-interactive
    # Commands to run in interactive sessions can go here
end

set BREW_BIN /home/linuxbrew/.linuxbrew/bin/brew

eval ($BREW_BIN shellenv)

# if not set -q TMUX
#     tmux
# end

if not set -q ZELLIJ
    zellij
end

starship init fish | source
atuin init fish | source

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
mkdir -p ~/.config/fish/completions

set -x LS_COLORS "di=38;5;67:ow=48;5;60:ex=38;5;132:ln=38;5;144:*.tar=38;5;180:*.zip=38;5;180:*.jpg=38;5;175:*.png=38;5;175:*.mp3=38;5;175:*.wav=38;5;175:*.txt=38;5;223:*.sh=38;5;132"
set -g fish_greeting ""

## alias
alias ls='lsd'
alias fzfbat='fzf --preview="bat --theme=gruvbox-dark --color=always {}"'
alias fzfnvim='nvim (fzf --preview="bat --theme=gruvbox-dark --color=always {}")'
alias ft='fastfetch --logo Xenia'
alias ll='ls -l'
alias lla='ls -la'

set -x EDITOR nvim

set -gx PROJECT_PATHS ~/Development

# kanagawa dragon colors
set -l foreground C5C9C5 # dragonWhite - un blanco suave para texto principal
set -l selection 2D4F67 # waveBlue2 - azul oscuro para selección
set -l comment 7A8382 # dragonGray3 - gris para comentarios
set -l red C4746E # dragonRed - rojo suave
set -l orange B98D7B # dragonOrange2 - naranja suave
set -l yellow C4B28A # dragonYellow - amarillo cálido
set -l green 87A987 # dragonGreen - verde pastel
set -l purple 957FB8 # oniViolet - púrpura suave
set -l cyan 8EA4A2 # dragonAqua - verde azulado
set -l pink D27E99 # sakuraPink - rosa suave

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

