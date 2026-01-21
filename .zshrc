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



# Add date-time to RPROMPT, adapted from: https://github.com/sindresorhus/pure/issues/667
# eval "original_$(declare -f prompt_pure_preprompt_render)"
# prompt_pure_preprompt_render() {
#   local prompt_pure_date_color='239'
#   local prompt_pure_date_format="[%y/%m/%d %H:%M:%S]"
#   zstyle -t :prompt:pure:date color
#   if [ $? -eq 1 ]; then
#     zstyle -s :prompt:pure:date color prompt_pure_date_color
#   fi
#   zstyle -t :prompt:pure:date format
#   if [ $? -eq 1 ]; then
#     zstyle -s :prompt:pure:date format prompt_pure_date_format
#   fi
#   local prompt_pure_date=$(date "+$prompt_pure_date_format")
#   original_prompt_pure_preprompt_render
#   RPROMPT="%F{$prompt_pure_date_color}${prompt_pure_date}%f"
# }

# Add just time to RPROMPT
RPROMPT="%F{214}%T%f"




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
__conda_setup="$('/home/tobias/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tobias/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tobias/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tobias/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

 bindkey '^ ' autosuggest-accept

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
