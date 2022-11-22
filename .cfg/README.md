# Installer les dotfiles

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' && echo ".cfg" >> .gitignore

git clone --bare git@github.com:meodbr/dotfiles.git $HOME/.cfg
