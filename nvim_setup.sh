
# download nvim appimage and install
cd ..
sudo apt install libfuse2
wget https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

cd dotfiles
# install nvchad
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
