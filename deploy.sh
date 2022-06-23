prompt_install() {
	echo -n "$1 is not installed. Would you like to install it? (y/n) " >&2
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg && echo
	if echo "$answer" | grep -iq "^y" ;then
	# This could def use community support
		if [ -x "$(command -v brew)" ]; then
			brew install $1
		else
			echo "I'm not sure what your package manager is! Please install $1 on your own and run this deploy script again." 
		fi
	fi
}

check_for_software() {
	echo "Checking to see if $1 is installed"
	if ! [ -x "$(command -v $1)" ]; then
		prompt_install $1
	else
		echo "$1 is installed."
	fi
}

check_default_shell() {
	if [ -z "${SHELL##*zsh*}" ] ;then
			echo "Default shell is zsh."
	else
		echo -n "Default shell is not zsh. Do you want to chsh -s \$(which zsh)? (y/n)"
		old_stty_cfg=$(stty -g)
		stty raw -echo
		answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
		stty $old_stty_cfg && echo
		if echo "$answer" | grep -iq "^y" ;then
			chsh -s $(which zsh)
		else
			echo "Warning: Somethings wrong."
		fi
	fi
}

install_prerequisite() {
	echo "We are going to install Brew, Brew Bundle. Init installation ? (y/n) ">&2
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg && echo
	if echo "$answer" | grep -iq "^y" ;then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew tap homebrew/bundle
	fi
}

init_brewfile_install() {
	echo "There is a Brewfile here, do you want to restore it ? (y/n)">&2
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg && echo
	if echo "$answer" | grep -iq "^y" ;then
		ln -s ~/dotfiles/Brewfile ~/Brewfile
		brew bundle
	fi
}

echo "We're going to do the following:"
echo "1. Check to make sure you have brew, brew bundle"
echo "2. Check to make sure you have zsh, vim installed"
echo "3. We'll help you install them if you don't"
echo "4. We're going to check to see if your default shell is zsh"
echo "5. We'll try to change it if it's not" 
echo "6. We will propose you to install the Brewfile"

echo "Let's get started? (y/n)"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
	echo 
else
	echo "Quitting, nothing was changed."
	exit 0
fi

install_prerequisite
echo
check_for_software zsh
echo 
check_for_software vim
echo
check_default_shell
echo
init_brewfile_install
echo

printf "source '$HOME/dotfiles/zsh/.zshrc'" > ~/.zshrc
printf "source $HOME/dotfiles/vim/.vimrc" > ~/.vimrc

echo
echo "Please log out and log back in for default shell to be initialized."
