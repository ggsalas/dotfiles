# GIT autocompleted
# Download from: https://gist.github.com/carlosvillu/e4ada4f991d495d07604
# source ~/.git-completion.sh

# prompt
# light="\[\033[38;5;4m\]"
# normal="\[\033[38;5;7m\]"
#
# export PS1="$light\n\$(__git_ps1 '%s • ')\w\[$(tput sgr0)\] $normal\n=> "

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias dotfiles='/usr/bin/git --git-dir=/Users/ggsalas/.dotfiles/ --work-tree=/Users/ggsalas'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

TERM='xterm-256color'
export AWS_PROFILE=indigo-ag
export IA_ENV=staging
export AWS_REGION=us-east-1
export AWS_SDK_LOAD_CONFIG=1
export AWS_PROFILE=credstash_stage
export PYENV_ROOT="$HOME/.pyenv"}
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PYENV_ROOT="$HOME/.pyenv"}
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PYENV_ROOT="$HOME/.pyenv"}
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

source /Users/ggsalas/Library/Preferences/org.dystroy.broot/launcher/bash/br
