DOTFILES="$HOME/git/dotfiles"

# Shared aliases
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"

# Custom bin path
export PATH="$HOME/git/dotfiles/bin:$PATH"

# OS detection
case "$OSTYPE" in
  darwin*) export OS="macOS" ;;
  linux*)  export OS="Linux" ;;
  *)       export OS="Unknown" ;;
esac
