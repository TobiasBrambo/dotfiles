
# download nvim appimage and install
cd ..
wget https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage
mkdir -p /opt/nvim
mv nvim.appimage /opt/nvim/neovim

export PATH="$PATH:/opt/nvim/"

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

cd dotfiles
# install nvchad
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
