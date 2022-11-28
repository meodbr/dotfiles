if status is-interactive
    # Commands to run in interactive sessions can go here
end

. ~/.config/shells/aliases.sh
#. ~/.config/shells/config.sh

fish_vi_key_bindings

fish_config theme choose "Catppuccin-macchiato"

set -gx PATH $PATH $HOME/.path/
set -gx EDITOR /snap/bin/nvim

# fzf opts
set -gx FZF_DEFAULT_COMMAND "find ." 
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND -type f"
set -gx FZF_CTRL_T_OPTS "--preview 'pygmentize -g -O style=catppuccinMacchiato {} | head -50'" 

set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND -type d"
set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -50'"

# improved cd
function cdt
    cd $argv && tree -L 2
end
function cdl
    cd $argv && ls
end

starship init fish | source
