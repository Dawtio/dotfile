#!/bin/bash

# Update stores
apt update

# Install brew as package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/maximeb/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/maximeb/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install package
apt install g++ -y       # dependency for neovim plugins
brew install node fzf rg # dependency for neovim plugins
brew install neovim

# Configure nvim
mkdir -p ~/.config/
cp -r nvim ~/.config/


