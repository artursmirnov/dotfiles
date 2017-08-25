#!/usr/bin/env bash

# definitions

SRC_DIR=~/src
OH_MY_ZSH_DIR=~/.oh-my-zsh
ZSH_PLUGINS_DIR=$OH_MY_ZSH_DIR/custom/plugins
DOTFILES_DIR=.
INSTALL_LOG_FILE=~/install_log.txt

touch $INSTALL_LOG_FILE

# functions

installWatchman () {
    if [ ! -d ~/.watchman ] ; then 
		git clone https://github.com/facebook/watchman.git ~/.watchman
	fi
	echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
	sudo sysctl -p
	cd ~/.watchman
	./autogen.sh
	./configure
	make
	sudo make install
	cd ~
}

addAptKeys () {
	# yarn
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
}

addAptRepos () {
	sudo add-apt-repository -y ppa:neovim-ppa/stable
}

installAptDeps () {
	sudo apt-get install -y build-essential cmake libssl-dev libfontconfig1 python-dev python-pip python3-dev python3-pip automake autoconf libtool pkg-config silversearcher-ag jq
	
}

installAptApp () {
	sudo apt-get install -y $1
}

initialSetup () {
	addAptKeys
	addAptRepos
	sudo apt-get update
	installAptDeps
}

installNeovim () {
	sudo apt-get install -y neovim 
	pip3 install neovim 
}

installFonts () {	
	local NERD_FONTS_DIR=~/.nerd-fonts
	
	if [ ! -d $NERD_FONTS_DIR ] ; then
		git clone https://github.com/ryanoasis/nerd-fonts $NERD_FONTS_DIR --depth 1
		cd $NERD_FONTS_DIR
		./install.sh SourceCodePro 
		cd ~
	fi
}

installZsh () {
	installAptApp zsh
	installOhMyZsh
	installOhMyZshPlugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
}

installOhMyZsh () {
	if [ ! -d $OH_MY_ZSH_DIR ] ; then
		wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
		git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
		sudo chsh -s /bin/zsh vagrant
	fi
}

installOhMyZshPlugin () {
	local NAME=$1
	local DIR=$ZSH_PLUGINS_DIR/$NAME
	local REPO="$2"
	
	if [ ! -d $DIR ] ; then
		git clone $REPO $DIR
	fi
}

installNode () {
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

installRoR () {
	curl -sSL https://get.rvm.io | bash -s stable --rails
}

copyDotFiles () {
	cp -R --remove-destination $DOTFILES_DIR/. ~/
}

# process

echo "Copying dot files..."
copyDotFiles >> $INSTALL_LOG_FILE

echo "Performing initial setup..."
initialSetup >> $INSTALL_LOG_FILE

echo "Installing yarn..."
installAptApp yarn >> $INSTALL_LOG_FILE

echo "Installing mc..."
installAptApp mc >> $INSTALL_LOG_FILE

echo "Installing watchman..."
installWatchman >> $INSTALL_LOG_FILE

echo "Installing fonts..."
installFonts

echo "Installing zsh..."
installZsh >> $INSTALL_LOG_FILE

echo "Installing nodejs..."
installNode >> $INSTALL_LOG_FILE

echo "Installing ruby on rails..."
installRoR >> $INSTALL_LOG_FILE

echo "Installing Node Inspector..."
yarn global add node-inspector >> $INSTALL_LOG_FILE

echo "Installing TypeScript..."
yarn global add typescript >> $INSTALL_LOG_FILE

echo "Installing Tern..."
yarn global add tern >> $INSTALL_LOG_FILE

echo "Installing jshint..."
yarn global add jshint >> $INSTALL_LOG_FILE

echo "Installing eslint..."
yarn global add eslint >> $INSTALL_LOG_FILE

echo "Installing bower..."
yarn global add bower >> $INSTALL_LOG_FILE

echo "Installing phantomjs..."
yarn global add phantomjs-prebuilt >> $INSTALL_LOG_FILE

echo "Installing ember-cli..."
yarn global add ember-cli >> $INSTALL_LOG_FILE

echo "Setup done!"
