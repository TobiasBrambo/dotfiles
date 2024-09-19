# check if zsh is installed, and set it as default shell
if command -v zsh >/dev/null 2>&1; then
    echo "Zsh is installed."
    chsh -s $(which zsh)
    echo "Set zsh as default shell."
else
    echo "Zsh is not installed."
    sudo apt install zsh 

    if [ $? -eq 0 ]; then
        echo "Zsh is installed."
        chsh -s $(which zsh)
        echo "Set zsh as default shell."
    else
        echo "Failed to install zsh."
    fi
fi


# download and install omz
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# download and install plugins for omz
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/conda-incubator/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion

# download and install pure theme
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
