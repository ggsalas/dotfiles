local GLOBAL_BINDS="ctrl-d:preview-down,ctrl-u:preview-up,?:toggle-preview"
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_COMPLETION_TRIGGER='*'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_CTRL_R_OPTS='--sort --exact'
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --preview-window right:50% --height 100% --bind $GLOBAL_BINDS"

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

# Commands with ForGit:
#   glo -> git log
#   gd -> git diff
#   ga -> git add
#   grh -> git reset HEAD (unstage)
#   gi -> // git ignore generator
#   gcf -> git checkout-restore
#   gclean -> git clean
#   gss -> git stash show

export FORGIT_FZF_DEFAULT_OPTS="--height 100% --bind $GLOBAL_BINDS"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
