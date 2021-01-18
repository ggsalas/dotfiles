export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -R"
export BROWSER="Google Chrome"
export LANG="en_US.UTF-8"
export BAT_THEME=Dracula

# Kitty terminal
source ~/.config/zsh/kitty.zsh

# FZF 
source ~/.config/zsh/fzf.zsh

# Prompt
source ~/.config/zsh/prompt.zsh

# git
source ~/.config/zsh/git.zsh

# nnn
source ~/.config/nnn/nnn.zsh

# Moodys config
source ~/.moodys.zsh

#################################################################################
# Basic auto/tab complete:
#################################################################################
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
kitty + complete setup zsh | source /dev/stdin # Completion for kitty
_comp_options+=(globdots)		# Include hidden files.

#################################################################################
# Bindings
#################################################################################
# edit command line inside vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# Bind ctrl-p to ctrl-space
bindkey '^P' '\ed'

# autosuggestions config
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'

bindkey '^P' autosuggest-execute


#################################################################################
# Aliases
#################################################################################
# Neovim
alias vi="nvim"
alias vip="nvim -c 'term' -c 'file Console' -c 'term' -c 'file Server'"

# file snd folders
alias ..='cd ..'
alias ls="ls -Gla"
alias ll='n'
# alias ll='br -dp -gh'

# test with jest
alias tdebug="ndb npm run test -- --watch"
alias test="npm run test -- --watch"

# Others
alias reload='source ~/.zshrc'
alias untar='tar -xvf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias df='dotfiles'
alias yrc="yarn --registry ''"

alias feeds="newsboat"

alias canary='open -a Google\ Chrome\ Canary --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias chrome="open -a 'Google Chrome'"

alias docker-stop='docker stop $(docker ps -aq)'
alias docker-list='docker ps -aq'

alias login-aws='okta-aws test sts get-caller-identity'

# kill all proccess thar uses a specific port 
function kill-port() {
  port=$@

  kill $(lsof -t -i:${port})
}


# readbility link open "Read Web"
# alias read='readable URL -p html-title,html-content | w3m -T text/html'
rw () {
   readable $1 -p html-title,html-content | w3m -T text/html
}

#################################################################################
# nvm
#################################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

#################################################################################
# Load plugins
#################################################################################
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
# git clone https://github.com/wfxr/forgit.git ~/.zsh/forgit
source ~/.zsh/forgit/forgit.plugin.zsh
# require install with brew: brew install autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
