[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="/usr/local/bin:$PATH"
export EDITOR='nvim'
export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/bin:$GOPATH/bin"
export LANGUAGE=es_ES:es
export ZSH_TMUX_FORCEUTF8=true

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

# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

source /Users/ggsalas/Library/Preferences/org.dystroy.broot/launcher/bash/br

#################################################################################
# FZF                                                                      START
#################################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export LANG="en_US.UTF-8"
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
#
# # tabtab source for serverless package
# # uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/serverless.zsh
# # tabtab source for sls package
# # uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ggsalas/Developer/Rocket/Indigo/marketplace-api/node_modules/tabtab/.completions/sls.zsh

# Enable Credstash to load local AWS config
export AWS_SDK_LOAD_CONFIG=true

# #################################################################################
# # nvm with lazy load to spped up terminal
# #################################################################################
# # https://gist.github.com/fl0w/07ce79bd44788f647deab307c94d6922#gistcomment-3275421
# # Add every binary that requires nvm, npm or node to run to an array of node globals
# NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")
# NODE_GLOBALS+=("npx")
#
# # Lazy-loading nvm + npm on node globals call
# load_nvm () {
#   export NVM_DIR=~/.nvm
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
#   if [ -f "$NVM_DIR/bash_completion" ]; then
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
#   fi
# }
#
# # Making node global trigger the lazy loading
# for cmd in "${NODE_GLOBALS[@]}"; do
#   eval "${cmd}(){ unset -f ${cmd} >/dev/null 2>&1; load_nvm; ${cmd} \$@; }"
# done
