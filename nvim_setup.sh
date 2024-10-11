#±/bin/bash

OS=$(uname)

if [ "$OS" == "Darwin" ]; then
    # macOS specific commands
    echo "Running macOS specific commands..."

    cd ..
    brew install neovim
    brew link neovim

    sudo rm -rf ~/.config/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.local/share/nvim

    sudo git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
    sudo chown -R $USER ~/.config/nvim



elif [ "$OS" == "Linux" ]; then
    # Linux specific commands
    echo "Running Linux specific commands..."

    # download nvim appimage and install
    cd ..
    sudo apt install libfuse2
    wget https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim.appimage
    sudo chmod u+x nvim.appimage && ./nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim

    # install ripgrep
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

    cd dotfiles
    # install nvchad
    git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

else
    echo "Unsupported operating system: $OS"
    exit 1
fi

