# my dotfiles

Various dotfiles I use — portable across macOS and Linux.

## Features

- Clean bash/zsh config with shared aliases
- macOS + Linux compatible
- Safe installs with backups of original files
- Includes support for:
  - tmux
  - htop
  - watch
  - vim with sensible defaults
- Symlinks dotfiles into place
- Uses brew bundle on macOS to install packages

## Quick Install

```bash
bash <(curl -s https://raw.githubusercontent.com/jsivilli/dotfiles/main/remote-bootstrap.sh)

## ⚠️  Requires git. If not installed:

sudo yum install git   # Amazon Linux / RHEL
sudo apt install git   # Debian / Ubuntu
sudo dnf install git   # Fedora

## Manual Install (if preferred)

git clone https://github.com/jsivilli/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh

## Notes

- Backups of original files are saved with a .backup suffix if they already exist.
- You can add your own custom scripts in ~/.dotfiles/bin/ — it's already on your $PATH.

## License

MIT — but honestly, use it however you like.

