#!/bin/sh

# Homebrew Script for OSX
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

# echo "Installing brew..."
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


#Programming Languages
brew install node
# brew install ruby
# brew install python
# brew install python@2

# #Databases
brew install postgresql
brew install --cask postico
# # TODO: seems failing both mongo...
brew install mongodb
brew install mongodb-community

# #Dev Tools
brew install npm
brew install yarn
# brew install gnupg
# brew install --cask iterm2
brew install --cask docker
brew install --cask postman
brew install --cask visual-studio-code
brew install --cask virtualbox
# brew install ripgrep
# brew install the_silver_searcher

# Terminal tools
brew install zsh
brew install zsh-autosuggestions
brew install --cask kitty
brew install tree
brew install mediainfo
brew install autojump
brew install dark-mode
brew install octavore/tools/delta
brew install git-delta
brew install broot
brew install nnn
brew install highlight

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font



#Communication Apps
# brew install --cask keybase
brew install --cask slack
brew install --cask skype
brew install --cask discord
brew install --cask whatsapp
brew install --cask element
brew install newsboat

# 
# #Web Tools
brew install --cask google-chrome
brew install --cask brave-browser
brew install --cask firefox
# brew install --cask google-chrome-canary
# 
# #Other tools
brew install --cask simplenote
brew install --cask karabiner-elements
brew install --cask rectangle
# brew install --cask easy-move-plus-resize
brew install --cask gimp
brew install --cask inkscape
brew install --cask blender
# brew install --cask scribus
# brew install --cask alfred
brew install --cask vlc
brew install --cask transmission
brew install --cask spotify
brew install --cask libreoffice
brew install --cask the-unarchiver
brew install --cask calibre

# Neovim 0.5
brew install neovim --HEAD
brew install ripgrep
npm install -g neovim prettier eslint
"npm install -g typescript-language-server


# install Plug for vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 
# echo "Installing other sofware without brew"
# # gem update neovim
# # npm install -g neovim
# # pip install pynvim
# # pip install neovim
# # pip3 install pynvim
# # pip3 install neovim
# # sudo gem install neovim
# 
# # install Plug for vim
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# git clone https://github.com/wfxr/forgit.git ~/.zsh/forgit
 
brew upgrade
