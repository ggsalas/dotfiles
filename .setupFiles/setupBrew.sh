#!/bin/sh

# Homebrew Script for OSX
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing brew cask..."
brew tap caskroom/cask

echo "Installing brew cask versions"
brew tap homebrew/cask-versions

#Programming Languages
brew install node
brew install ruby
brew install python
brew install python@2

#Databases
brew install postgresql
brew cask install postico
# TODO: seems failing both mongo...
brew install mongodb
brew install mongodb-community

#Dev Tools
brew install git
brew install yarn
brew install tmux
brew install gnupg
brew install ripgrep
brew install the_silver_searcher
brew install neovim
brew cask install kitty
brew install dark-mode
brew cask install alacritty
brew cask install iterm2
brew cask install docker
brew cask install postman
brew cask install visual-studio-code
brew install tree
brew install zsh
brew install antigen
brew install zsh-autosuggestions
brew cask install virtualbox

#Communication Apps
brew cask install keybase
brew cask install slack
brew cask install skype

#Web Tools
brew cask install firefox-developer-edition
brew cask install google-chrome
brew cask install google-chrome-canary

#Other tools
brew cask install spectacle
brew cask install easy-move-plus-resize
brew cask install gimp
brew cask install xquartz
brew cask install inkscape
brew cask install blender
brew cask install scribus
brew cask install alfred
brew cask install vlc
brew cask install transmission
brew cask install spotify
brew cask install libreoffice
brew cask install the-unarchiver
brew cask install calibre

echo "Installing other sofware without brew"
gem update neovim
npm install -g neovim
pip install pynvim
pip install neovim
pip3 install pynvim
pip3 install neovim
sudo gem install neovim
# install Plug for vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install plug for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

npm install --global git-open

# brew upgrade
