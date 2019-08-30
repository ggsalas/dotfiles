#!/bin/sh

# Homebrew Script for OSX
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing brew cask..."
brew tap caskroom/cask

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

#Web Tools
brew cask install google-chrome
brew cask install firefox

#Other tools
brew cask install google-drive
brew cask install easy-move-plus-resize
brew cask install gimp
brew cask install inkscape
brew cask install xquartz
brew cask install font-source-code-pro
brew cask install alfred
brew cask install vlc
brew cask install transmission
brew cask install spotify
brew cask install whatsup
