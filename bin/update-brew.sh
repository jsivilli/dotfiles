#!/bin/bash

echo ""
echo "========================================="
echo "🍺 Updating Homebrew Packages"
echo "========================================="
brew update
brew upgrade
brew autoremove
brew cleanup
echo "========================================="
echo ""

