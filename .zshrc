export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export BROWSER="brave"
export LANG="en_US.UTF-8"

export AWS_PROFILE=indigo-ag
export IA_ENV=staging
export AWS_REGION=us-east-1
export AWS_SDK_LOAD_CONFIG=1
export PYENV_ROOT="$HOME/.pyenv"}
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PATH="/usr/local/sbin:$PATH"
export AWS_PROFILE=credstash_stage
export BAT_THEME=Dracula
export NNN_PLUG='p:-_less -iR $nnn*;g:-_git diff;l:-_git log;o:_preview-tui'

# Kitty terminal
source ~/.config/zsh/kitty.zsh

# FZF 
source ~/.config/zsh/fzf.zsh

# Prompt
source ~/.config/zsh/prompt.zsh

# git
source ~/.config/zsh/git.zsh

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
alias ll='lf'
# alias ll='br -dp -gh'

# test with jest
alias tdebug="ndb npm run test -- --watch"
alias test="npm run test -- --watch"

# Others
alias reload='source ~/.zshrc'
alias untar='tar -xvf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias yrc="yarn --registry ''"

alias feeds="newsboat"

alias canary='open -a Google\ Chrome\ Canary --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias chrome="open -a 'Google Chrome'"

#################################################################################
# nvm
#################################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# # tabtab source for serverless package
# # uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh
# # tabtab source for sls package
# # uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh

# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

#################################################################################
# Load plugins
#################################################################################
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
# git clone https://github.com/wfxr/forgit.git ~/.zsh/forgit
source ~/.zsh/forgit/forgit.plugin.zsh
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Broot
# source /Users/ggsalas/Library/Preferences/org.dystroy.broot/launcher/bash/br
