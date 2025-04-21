#!/usr/bin/env bash
set -e

REPO="https://github.com/jsivilli/dotfiles.git"
CLONE_DIR="$HOME/.dotfiles"

echo "📦 Bootstrapping dotfiles from $REPO..."

# Check for git, but don't auto-install
if ! command -v git &>/dev/null; then
  echo "❌ 'git' is required but not installed."
  echo "➡️  Please install git manually (e.g. 'sudo apt install git' or 'sudo yum install git')"
  exit 1
fi

# Clone dotfiles repo if it doesn't exist
if [ ! -d "$CLONE_DIR" ]; then
  echo "📁 Cloning dotfiles to $CLONE_DIR..."
  git clone "$REPO" "$CLONE_DIR"
else
  echo "✅ Dotfiles already cloned at $CLONE_DIR"
fi

cd "$CLONE_DIR"

# Run the internal bootstrap
echo "🚀 Running internal bootstrap.sh..."
chmod +x bootstrap.sh
./bootstrap.sh

