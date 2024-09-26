# Dotfiles WIP

.dotfiles for my personal setup. provided as is etc.etc.etc.

Before install do sudo apt update, then run setup scripts for the parts you want.

After installation, install stow:

sudo apt install stow

then run this from `dotfiles` dir:

1. stow --adopt .
2. git restore .
3. stow .

now it should just work
