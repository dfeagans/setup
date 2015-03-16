#!/bin/bash
# dfeagans AWS EC2 Ubuntu Configuration Script

# Moves to the home directory first so the git clone and symlinking work correctly.
    cd $HOME

# Install git
    sudo apt-get install -y git
    
# Install curl and wget (Both are installed by default on Ubuntu, but just in case un-comment)
    # sudo apt-get install -y curl
    # sudo apt-get install -y wget
    
# Install nvm and node
    curl https://raw.github.com/creationix/nvm/master/install.sh | sh
    source $HOME/.nvm/nvm.sh
    nvm install stable
    nvm use stable
    
# Install jshint (might be unecessary depending on final emacs/javascript IDE I work out)
    npm install -g jshint
    
# Install rlwrap to provide some history to the node repl
    sudo apt-get install -y rlwrap

# Install emacs24
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get -qq update
    sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Rename the existing .emacs.d and dotfiles directories if they exist, because git clone can't overwrite
    # if [ -d ./dotfiles/ ]; then
    #   mv dotfiles dotfiles.old
    # fi
    # if [ -d ./.emacs.d/ ]; then
    #   mv .emacs.d .emacs.d~
    # fi
    
# Grab and symlink dotfiles into the correct locations
# -b (backup) option is used because again, ln won't work if the file exists. -b adds ~ to the existing file
    git clone https://github.com/dfeagans/dotfiles.git
    ln -sb dotfiles/.screenrc .
    ln -sb dotfiles/.bash_profile .
    ln -sb dotfiles/.bashrc .
    ln -sb dotfiles/.gitconfig .
    ln -sb dotfiles/.gitignore_global . 
    # ln -sf dotfiles/.emacs.d .  #DON'T USE. DEVELOPING BETTER METHOD FOR MANAGING EMACS CONFIGURATION.

# Makes github use the .gitignore_global file.
    git config --global core.excludesfile ~/.gitignore_global
