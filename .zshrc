source /usr/local/share/antigen/antigen.zsh
export PATH="/usr/local/bin:$PATH"
export EDITOR='nvim'

#################################################################################
# Load plugins
#################################################################################
antigen use oh-my-zsh
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
bindkey '^P' autosuggest-execute

#################################################################################
# Aliases
#################################################################################

# Neovim
alias vi="nvim"
alias vip="nvim -c 'term' -c 'file Console' -c 'term' -c 'file Server'"

# file snd folders
alias ..='cd ..'
alias ls='br -gh'
alias ll='br -dp -gh'

# test with jest
alias tdebug="ndb npm run test -- --watch"
alias test="npm run test -- --watch"

# Others
alias reload='source ~/.zshrc'
alias untar='tar -xvf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias yrc="yarn --registry ''"

alias canary='open -a Google\ Chrome\ Canary --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

#################################################################################
# Dark/Light modes
#################################################################################
local LIGHT=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorLight.conf)
local DARK=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorDark.conf)

if [[ ( $(dark-mode status) =~ 'on' ) ]]; then
  $DARK
else
  $LIGHT
fi

export ZSH_TMUX_FORCEUTF8=true

#################################################################################
# FZF                                                                       START
#################################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export LANG="en_US.UTF-8"

#################################################################################
# Prompt                                                                    START
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

#
# Hooks
#
autoload -U add-zsh-hook
# for prompt
add-zsh-hook precmd vcs_info

# Prompt                                                                      END
#################################################################################

#################################################################################
# nnn config                                                                START
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -e "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
# nnn config                                                                  END
#################################################################################


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh

# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true


# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true


# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

source /Users/ggsalas/Library/Preferences/org.dystroy.broot/launcher/bash/br
