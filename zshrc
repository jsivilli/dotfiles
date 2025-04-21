DOTFILES="$HOME/git/dotfiles"

# Shared aliases and bashrc
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"
[ -f "$DOTFILES/bashrc" ] && source "$DOTFILES/bashrc"
