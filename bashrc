DOTFILES="$HOME/.dotfiles"

# Shared aliases
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"

# Custom bin path
export PATH="$HOME/.dotfiles/bin:$PATH"

# OS detection
case "$OSTYPE" in
  darwin*) export OS="macOS" ;;
  linux*)  export OS="Linux" ;;
  *)       export OS="Unknown" ;;
esac

