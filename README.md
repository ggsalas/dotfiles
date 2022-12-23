# Dotfiles

Those dotfiles are managed with a [bare Git repository](#how-to).

## Nvim configs of inspiration

Where I have copy/pasted many configs :)

- [kickstar](https://github.com/nvim-lua/kickstart.nvim)
- [init.lua](https://github.com/ThePrimeagen/init.lua)
- [from scratch](https://github.com/LunarVim/Neovim-from-scratch)
- [LunarVim](https://github.com/ChristianChiarulli/LunarVim)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/1b8ab10ddc06217cd532376e52d74678c3a0e805/xdg_config/nvim)
- [ThePrimeagen](https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen)
- [wincent](https://github.com/wincent/wincent/tree/632aa515e22ac7203418c0b597c0ff7de4e15878/aspects/vim/files/.Vim)

## How to

The idea is well explained [on this vieo](https://www.youtube.com/watch?v=tBoLDpTWVOM) and on [this post of atlassian](https://www.atlassian.com/git/tutorials/dotfiles).

1.  On your _home directory_ you need to do:

```bash
## Create a folder on $HOME
mkdir .dotfiles

## init git bare repo
git init --bare $HOME/.dotfiles

## create an alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## avoid show untracked files
dotfiles config --local status.showUntrackedFiles no

## add the repo as remote origin
dotfiles remote add origin git@github.com:ggsalas/dotfiles.git

## replace all tracked files with the repo files
dotfiles fetch
dotfiles pull origin master
dotfiles reset --hard origin/master
dotfiles branch --set-upstream-to=origin/master master
dotfiles pull
```

2. Now you can use the `dotfiles` repo as it was `git` command. Example:

```bash
dotfiles add .zshrc
dotfiles commit
dotfiles push
```

### How this repo was created

To create a new git bare repo to handle your dotfiles you only need to do this:

```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

also add a alias on `.zshrc` or `.bashrc`:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

To see the untracked files on a specific folder:

```bash
df status -u ~/<folder}
```
