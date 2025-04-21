#!/usr/bin/env bash
set -e

REPO="https://github.com/jsivilli/dotfiles.git"
CLONE_DIR="$HOME/.dotfiles"

echo "📦 Bootstrapping dotfiles from $REPO..."

# Clone if needed
if [ ! -d "$CLONE_DIR" ]; then
  echo "📁 Cloning dotfiles to $CLONE_DIR..."
  git clone "$REPO" "$CLONE_DIR"
fi

cd "$CLONE_DIR"

# Run the internal bootstrap
echo "🚀 Running internal bootstrap.sh..."
chmod +x bootstrap.sh
./bootstrap.sh

