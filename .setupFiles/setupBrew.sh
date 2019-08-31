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
brew install mongodb
brew install mongodb-community
brew cask install postico

#Dev Tools
brew install git
brew install yarn
brew install tmux
brew install neovim
brew cask install alacritty
brew cask install iterm2
brew cask install docker
brew cask install postman
brew cask install visual-studio-code
brew install tree
brew install zsh
brew install zsh-autosuggestions
brew cask install virtualbox

#Communication Apps
brew cask install keybase
brew cask install slack
brew cask install skype
brew cask install skype-for-business

#Web Tools
brew cask install firefox-developer-edition
brew cask install google-chrome
brew cask install google-chrome-canary

#Other tools
brew cask install google-drive
brew cask install easy-move-plus-resize
brew cask install gimp
brew cask install inkscape
brew cask install xquartz
brew cask install blender
brew cask install scribus
brew cask install font-source-code-pro
brew cask install alfred
brew cask install vlc
brew cask install transmission
brew cask install spotify
brew cask install libreoffice
brew cask install the-unarchiver

echo "Installing other sofware without brew"
gem update neovim
npm install -g neovim
pip install pynvim
pip install neovim
pip3 install pynvim
pip3 install neovim
# pip2 install --upgrade neovim
# pip3 install --upgrade neovim

# brew upgrade
