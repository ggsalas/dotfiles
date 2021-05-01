local GLOBAL_BINDS="ctrl-d:preview-down,ctrl-u:preview-up,?:toggle-preview"
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_COMPLETION_TRIGGER='*'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS='--sort --exact --layout=reverse'
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --preview-window right:50% --height 100% --bind $GLOBAL_BINDS"
export FORGIT_FZF_DEFAULT_OPTS="--layout=reverse --height 100% --bind $GLOBAL_BINDS"

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# #################################################################################
# Git
# #################################################################################
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
