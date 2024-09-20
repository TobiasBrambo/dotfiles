# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="" # set by `omz`, using pure

# Extra installed plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search conda-zsh-completion)


source $ZSH/oh-my-zsh.sh

# Setup pure theme
fpath+=($HOME/.zsh/pure)
autoload -U compinit && compinit
autoload -U promptinit; promptinit
prompt pure


if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tobxtra/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tobxtra/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tobxtra/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tobxtra/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
