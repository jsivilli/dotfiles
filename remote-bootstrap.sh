#!/usr/bin/env bash
set -e

REPO="https://github.com/jsivilli/dotfiles.git"
CLONE_DIR="$HOME/.dotfiles"

echo "📦 Bootstrapping dotfiles from $REPO..."

# 🧪 Ensure git is installed before cloning
if ! command -v git &>/dev/null; then
  echo "🛠 git not found — attempting to install..."

  if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y git
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y git
  elif command -v yum &>/dev/null; then
    sudo yum install -y git
  else
    echo "❌ No supported package manager found. Please install git manually."
    exit 1
  fi
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
