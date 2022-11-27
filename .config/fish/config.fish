if status is-interactive
    # Commands to run in interactive sessions can go here
end

. ~/.config/shells/aliases.sh
#. ~/.config/shells/config.sh

fish_vi_key_bindings

fish_config theme choose "Catppuccin-macchiato"

set -gx PATH $PATH $HOME/.path/
set -gx EDITOR /snap/bin/nvim

# improved cd
function cdt
    cd $argv && tree -L 2
end
function cdl
    cd $argv && ls
end

starship init fish | source
