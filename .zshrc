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

export PATH="$PATH:/opt/nvim/"

alias conda-init-zsh="~/anaconda3/bin/conda init zsh"

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export PATH=$PATH:$CUDA_HOME/bin


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
