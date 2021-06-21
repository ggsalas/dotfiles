# Uncomment this to configure for first time
# $(brew --prefix)/opt/fzf/install

local GLOBAL_BINDS="ctrl-d:preview-down,ctrl-u:preview-up,?:toggle-preview"
export FZF_COMPLETION_TRIGGER=';'
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow -g '!{node_modules,.git,Google\ Drive,Library}'"
# export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --preview-window right:50% --height 100% --bind $GLOBAL_BINDS"
export FZF_CTRL_R_OPTS='--sort --layout=reverse'
# export FZF_ALT_C_COMMAND='blsd'
export FZF_ALT_C_COMMAND="find -L . \\( -path '*/\\.*' -o -path '*/node_modules*' -o -path '*/.git*' \\) -prune -o -type d -print 2> /dev/null"
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# export FORGIT_FZF_DEFAULT_OPTS="--bind $GLOBAL_BINDS"
export FORGIT_FZF_DEFAULT_OPTS="--layout=reverse --preview-window :hidden --bind $GLOBAL_BINDS"

bindkey '^j' 'fzf-cd-widget'
bindkey '^k' 'fzf-file-widget'

# # jump_directory - cd to selected directory
# jump-directory() {
#   # cd $(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m --layout=reverse --height=50%)
#   cd $(find ${1:-.} \\( -path '*/\\.*' -o -path '*/node_modules*' -o -path '*/.git*' \\) -prune -o -type d -print 2> /dev/null | fzf +m --layout=reverse --height=50%)
# }
# zle -N jump-directory jump-directory
# bindkey -s '^k' 'jump-directory^M'

# gitfiles() {
#   git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o
# }
# zle -N gitfiles gitfiles
# bindkey '^f' gitfiles


# #################################################################################
# Git
# #################################################################################
forgit_log=g-log
forgit_diff=g-diff
forgit_add=g-add
forgit_reset_head=g-reseth
forgit_ignore=g-ignore
forgit_checkout_file=g-chfile
forgit_checkout_branch=g-chbranch
forgit_checkout_commit=g-chcommit
forgit_clean=g-clean
forgit_stash_show=g-stash
forgit_cherry_pick=g-chpick
forgit_rebase=g-rebase
forgit_fixup=g-fixup

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gb() {
  is_in_git_repo || return
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"
_viewGitLogLineUnfancy="$_gitLogLineToHash | xargs -I % sh -c 'git show %'"

# fshow_preview - git commit browser with previews
gls() {
  glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
    --ansi --preview="$_viewGitLogLine" \
    --header "enter to view, alt-y to copy hash, alt-v to open in vim" \
    --bind "enter:execute:$_viewGitLogLine   | less -R" \
    --bind "ctrl-e:execute:$_viewGitLogLineUnfancy | nvim -" \
    --bind "ctrl-y:execute:$_gitLogLineToHash | pbcopy"
}

# Commands with ForGit:
#   glo -> git log
#   gd -> git diff
#   ga -> git add
#   grh -> git reset HEAD (unstage)
#   gi -> // git ignore generator
#   gcf -> git checkout-restore
#   gclean -> git clean
#   gss -> git stash show

alias glog='glo'
alias gdiff='gd'
alias gadd='gadd'
alias gstash='gss'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
