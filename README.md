# Dotfiles

Those dotfiles are managed with a bare Git repository. The idea is well explained [on this vieo](https://www.youtube.com/watch?v=tBoLDpTWVOM) and on [this post of atlassian](https://www.atlassian.com/git/tutorials/dotfiles)

## How to use
1.  On your *home directory* you need to clone this repo

2. To _use_ this repo you only need to replace `git` command by `dotfiles` command on any folder inside your home directory.

Example:
```
dotfiles add .zshrc
dotfiles commit
dotfiles push
```

## How this repo was created

```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

also add a alias on `.zshrc`:
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
