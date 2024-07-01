# Dotfiles

Repo containing dot files for my personal setup.

Requires installing tpm for tmux plugins: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## Usage:
1. Clone repo to home directory.
2. Install GNU stow: `sudo apt install stow` (for Ubuntu)
3. cd to dotfiles repo, and run `stow .` to symlink all files to home directory. (--adopt flag can be used to overwrite existing files)
