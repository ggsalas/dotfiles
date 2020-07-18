export PATH="/usr/local/bin:$PATH"
export EDITOR='nvim'
export LANGUAGE=es_ES:es
export ZSH_TMUX_FORCEUTF8=true
export TERM='xterm-256color'

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
