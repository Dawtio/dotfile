#!/bin/bash

# Update stores
sudo apt update

# Install brew as package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install package
sudo apt install g++ -y  # dependency for neovim plugins
brew install node fzf rg # dependency for neovim plugins
brew install neovim
brew install tmux

# Configure nvim
mkdir -p ~/.config/
cp -r nvim ~/.config/

# Configure tmux
ls -s -f tmux/.tmux.conf ~/.tmux.conf
cp tmux/.tmux.conf.local ~/.tmux.conf.local

