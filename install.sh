#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_and_link() {
  src="$1"
  dest="$HOME/.$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "🗂 Backing up $dest to $dest.backup"
    mv "$dest" "$dest.backup"
  fi
  ln -sf "$DOTFILES_DIR/$src" "$dest"
  echo "✅ Linked $src -> $dest"
}

echo "🔧 Installing dotfiles..."

backup_and_link "zshrc" "zshrc"
backup_and_link "bashrc" "bashrc"
backup_and_link "vimrc" "vimrc"
backup_and_link "aliases" "aliases"
backup_and_link "tmux.conf" "tmux.conf"
backup_and_link "bash_profile" "bash_profile"
backup_and_link "profile" "profile"

echo "🎉 Done!"

