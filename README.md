# Awesome Dotfiles

My dotfile configuration with Brew, Zsh and Vim.

To make your own dotfiles project, fell free to fork this one.

## Before re-install

### Todo list:
- Make sure you have saved your SSH and GPG keys file
- Make a ```brew bundle dump``` to keep your app
- Make sure all of your projects was git and on their servers.
- Make sure your personnal data was saved somewhere (Documents,Images,Videos,Music)

## Installation

Make sure you have git installed on the machine \
You can test with the following command:
### MacOS

```sh
git version

# if it's not installed
xcode-select --install
```

### Linux

```sh
git version
curl --help
ruby --help

# if it's not installed
apt-get update
apt-get upgrade
apt-get install git curl ruby
```

### Common steps

Clone the repo into your $HOME folder
```
cd ~/
git clone -b main https://github.com/Dawtio/dotfile.git
```

Once the repo is cloned, execute the deploy script:
```
cd dotfiles/
chmod +x deploy.sh
./deploy.sh
```

# Author

- BRUNET Maxime (mbrunet@dawtio.cloud)
