# Dotfiles

Those dotfiles are managed with a bare Git repository. The idea is well explained [on this vieo](https://www.youtube.com/watch?v=tBoLDpTWVOM) and on [this post of atlassian](https://www.atlassian.com/git/tutorials/dotfiles)

## How to use
1.  On your *home directory* you need to clone this repo
```
// Create a folder
mkdir .dotfiles

// init git bare repo
git init --bare $HOME/.dotfiles

// create an alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

// avoid show untracked files
dotfiles config --local status.showUntrackedFiles no

// add this repo as remote origin
dotfiles remote add origin git@github.com:ggsalas/dotfiles.git

// replace all tracked files with the repo files
dotfiles fetch
dotfiles pull origin master
dotfiles reset --hard origin/master
dotfiles branch --set-upstream-to=origin/master master 
dotfiles pull
```

2. To _use_ this repo you only need to replace `git` command by `dotfiles` command on any folder inside your home directory.

Example:
```
dotfiles add .zshrc
dotfiles commit
dotfiles push
```

## How this repo was created

To create a new git bare repo to handle your dotfiles you only need to do this:

```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

also add a alias on `.zshrc` or `.bashrc`:
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
