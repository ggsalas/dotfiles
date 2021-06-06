#!/bin/bash

git --git-dir $HOME/.dotfiles/ ls-files --full-name | sed "s,^,$HOME/," 
