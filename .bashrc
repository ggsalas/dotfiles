export PATH="/usr/local/bin:$PATH"
export EDITOR='nvim'
export LANGUAGE=es_ES:es
export ZSH_TMUX_FORCEUTF8=true
export TERM='xterm-256color'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
