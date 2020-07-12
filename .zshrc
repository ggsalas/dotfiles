export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export BROWSER="brave"
export PATH="/usr/local/sbin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"}
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

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
# Dark/Light modes for kitty terminal
#################################################################################

kittyDarkMode() {
  if [[ $(echo $TERM) == 'xterm-kitty' ]] then
    local LIGHT=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorLight.conf)
    local DARK=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorDark.conf)

    if [[ ( $(dark-mode status) =~ 'on' ) ]]; then
      $DARK
    else
      $LIGHT
    fi
  fi
}

#################################################################################
# FZF                                                                      START
#################################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export LANG="en_US.UTF-8"

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

alias clear="clear && kittyDarkMode"
alias colorDark="dark-mode on && kittyDarkMode"
alias colorLight="dark-mode off && kittyDarkMode"

# open git repo on current branch
gopen() {
    file=${1:-""}
    git_branch=${2:-$(git symbolic-ref --quiet --short HEAD)}
    git_project_root=$(git config remote.origin.url | sed "s~git@\(.*\):\(.*\)~https://\1/\2~" | sed "s~\(.*\).git\$~\1~")
    git_directory=$(git rev-parse --show-prefix)
    open ${git_project_root}/tree/${git_branch}/${git_directory}${file}
}

#################################################################################
# TWF                                                                       START
#################################################################################
twf-widget() {
  local selected=$(twf --height=0.5)
  BUFFER="$BUFFER$selected"
  zle reset-prompt
  zle end-of-line
  return $ret
}
zle -N twf-widget
bindkey '^T' twf-widget

#################################################################################
# Prompt                                                                    START
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""
autoload -U colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}● %f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}● %f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '%F{cyan}%b%f %m%c%u ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
zstyle ':vcs_info:hg*:*' formats '[%m%b]'
zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
zstyle ':vcs_info:hg*:*' branchformat '%b'
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

function +vi-hg-bookmarks() {
  emulate -L zsh
  if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
    hook_com[hg-bookmark-string]="${(Mj:,:)@}"
    ret=1
  fi
}
function +vi-hg-message() {
  emulate -L zsh
  if [[ -n "${hook_com[misc]}" ]]; then
    hook_com[branch]=''
  fi
  return 0
}
function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}● %f"
  fi
}
RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f "
setopt PROMPT_SUBST

function () {
  if [[ -n "$TMUX" ]]; then
    local LVL=$(($SHLVL - 1))
  else
    local LVL=$SHLVL
  fi

  local SUFFIX=$(printf '❯%.0s' {1..$LVL})

  if [[ -n "$TMUX" ]]; then
    # Note use a non-breaking space at the end of the prompt because we can use it as
    # a find pattern to jump back in tmux.
    local NBSP=' '
    export PS1=" %F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{magenta}%B%(1j.* .)%b%f%F{yellow}%B${SUFFIX}%b%f "
    export ZLE_RPROMPT_INDENT=0
  else
    # Don't bother with ZLE_RPROMPT_INDENT here, because it ends up eating the
    # space after PS1.
    export PS1=" %F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{magenta}%B%(1j.* .)%b%f%F{yellow}%B${SUFFIX}%b%f "
  fi
}
export RPROMPT=$RPROMPT_BASE
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
# Prompt                                                                      END
#################################################################################

autoload -U add-zsh-hook
# for prompt
add-zsh-hook precmd vcs_info

#################################################################################
# Load plugins
#################################################################################
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Broot
source /Users/ggsalas/Library/Preferences/org.dystroy.broot/launcher/bash/br
