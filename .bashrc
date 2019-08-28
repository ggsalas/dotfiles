# GIT autocompleted
# Download from: https://gist.github.com/carlosvillu/e4ada4f991d495d07604
# then do: $ source ~/.bash_profile
source ~/.git-completion.sh

# prompt
# https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# 38: front color, 48: background color
light="\[\033[38;5;4m\]"
normal="\[\033[38;5;7m\]"

export PS1="$light\n\$(__git_ps1 '%s • ')\w\[$(tput sgr0)\] $normal\n=> "

## ALIAS ##
# Neovim
alias vi="nvim"
alias vip="nvim -c 'term' -c 'file Console' -c 'term' -c 'file Server'"

# file snd folders
alias ll="ls -ogpAhG"
alias .='clear'
alias ..='cd ..'

# Others
alias reload='source ~/.bashrc'
alias untar='tar -xvf'

# Iterm
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias dotfiles='/usr/bin/git --git-dir=/Users/ggsalas/.dotfiles/ --work-tree=/Users/ggsalas'
