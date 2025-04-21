#!/usr/bin/env bash
set -e

REPO="https://github.com/jsivilli/dotfiles.git"
CLONE_DIR="$HOME/.dotfiles"
INSTALL_SCRIPT="install.sh"

echo "🧼 Bootstrapping dotfiles for jsivilli..."
echo "📦 OS detected: $OSTYPE"

# Clone repo if it doesn't exist
if [ ! -d "$CLONE_DIR" ]; then
  echo "📁 Cloning dotfiles to $CLONE_DIR..."
  git clone "$REPO" "$CLONE_DIR"
else
  echo "📁 Dotfiles already cloned at $CLONE_DIR"
fi

cd "$CLONE_DIR"

# macOS setup
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "🍎 Detected macOS — checking for Homebrew..."

  if ! command -v brew &>/dev/null; then
    echo "🔧 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "✅ Homebrew already installed"
  fi

  # Fix PATH (especially for Apple Silicon)
  BREW_PREFIX="$(/opt/homebrew/bin/brew --prefix 2>/dev/null || echo "/opt/homebrew")"
  if [ -d "$BREW_PREFIX" ]; then
    echo "🛠 Adding Homebrew to PATH..."
    echo 'eval "$('"$BREW_PREFIX"'/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$("$BREW_PREFIX"/bin/brew shellenv)"
  fi

  echo "✅ Homebrew location: $(which brew)"

  # Install from Brewfile
  if [ -f Brewfile ]; then
    echo "📦 Installing packages from Brewfile..."
    brew bundle --file=Brewfile
  fi

# Linux setup
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "🐧 Detected Linux — checking for core packages..."

  # Detect package manager
  if command -v apt &>/dev/null; then
    PM="sudo apt install -y"
  elif command -v dnf &>/dev/null; then
    PM="sudo dnf install -y"
  elif command -v yum &>/dev/null; then
    PM="sudo yum install -y"
  else
    echo "❌ Unsupported package manager"
    exit 1
  fi

  # List of required packages
  REQUIRED_PKGS=(zsh curl git vim tmux htop watch)

  for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg &>/dev/null; then
      echo "📦 Installing $pkg..."
      $PM $pkg
    else
      echo "✅ $pkg already installed"
    fi
  done

else
  echo "⚠️ Unknown OS type: $OSTYPE — skipping package installs"
fi

# Run install.sh
echo "🚀 Running install.sh..."
chmod +x "$INSTALL_SCRIPT"
./"$INSTALL_SCRIPT"

echo "🎉 Dotfiles installed! Run 'exec zsh' to enter your new shell."

