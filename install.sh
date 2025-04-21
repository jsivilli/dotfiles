#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link_file() {
  src="$1"
  dest="$HOME/.$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "⚠️  Skipping $dest (already exists and is not a symlink)"
  else
    ln -sf "$DOTFILES_DIR/$src" "$dest"
    echo "✅ Linked $src -> $dest"
  fi
}

echo "🔧 Installing dotfiles..."

link_file "zshrc" "zshrc"
link_file "bashrc" "bashrc"
link_file "vimrc" "vimrc"
link_file "aliases" "aliases"

echo "🎉 Done!"
