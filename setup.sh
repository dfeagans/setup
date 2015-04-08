#!/bin/bash
# dfeagans AWS EC2 Ubuntu Configuration Script

# Moves to the home directory first so the git clone and symlinking work correctly.
    cd $HOME

# Install git
    echo -e '\E[37;44m'"\033[1m\n********** INSTALLING GIT **********\n\033[0m"
    sudo apt-get install -y git
    
# Install curl and wget (Both are installed by default on Ubuntu, but just in case un-comment)
    # sudo apt-get install -y curl
    # sudo apt-get install -y wget
    
# Install nvm, node, and npm.
    echo -e '\E[37;44m'"\033[1m\n********** INSTALLING NVM/NODE/NPM **********\n\033[0m"
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh
    source $HOME/.nvm/nvm.sh
    nvm install stable
    nvm alias default stable
    
# Install jshint (might be unecessary depending on final emacs/javascript IDE I work out)
    npm install -g jshint
    
# Install rlwrap to provide some history to the node repl
    sudo apt-get install -y rlwrap

# Install emacs24
    echo -e '\E[37;44m'"\033[1m\n********** INSTALLING EMACS **********\n\033[0m"
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get -qq update
    sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Rename the existing .emacs.d and dotfiles directories if they exist, because git clone can't overwrite
    if [ -d ./dotfiles/ ]; then
        mv dotfiles dotfiles.old
    fi
    # if [ -d ./.emacs.d/ ]; then
    #   mv .emacs.d .emacs.d~
    # fi
    
# Grab and symlink dotfiles into the correct locations
# -b (backup) option is used because again, ln won't work if the file exists. -b adds ~ to the existing file
    echo -e '\E[37;44m'"\033[1m\n********** CLONING AND SETTING UP DOTFILES **********\n\033[0m"
    git clone https://github.com/dfeagans/dotfiles
    ln -sb dotfiles/.screenrc .
    ln -sb dotfiles/.bash_profile .
    ln -sb dotfiles/.bashrc .
    ln -sb dotfiles/.gitconfig .
    ln -sb dotfiles/.gitignore_global .
    ln -sb ../dotfiles/init.el .emacs.d/.
    ln -sb ../dotfiles/my-packages.el .emacs.d/.

# Now that git is installed, proceed with as many steps as possible to connect Github account
    #Options used below:
        # -t rsa = type rsa
        # -N "" = use empty passhphrases
        # -C `git config user.email` = makes the comment whatever email git is configured for (adjust above)
        # -f ~/.ssh/id_rsa = resulting file is id_rsa
    echo -e '\E[37;44m'"\033[1m\n********** CREATING SSH-KEY FOR GITHUB CONNECTION **********\n\033[0m"
    ssh-keygen -t rsa -N "" -C `git config user.email` -f ~/.ssh/id_rsa 
    echo -e '\E[37;44m'"\033[1m\n********** REMAINING GITHUB CONNECTION STEPS **********\n\033[0m"
    echo -e '\E[37;44m'"\033[1m\n********** Log in to github and under Settings > SSH Keys paste the entire key below: **********\n\033[0m"
    cat .ssh/id_rsa.pub
    echo -e '\E[37;44m'"\033[1m\n********** TO TEST CONNECTION TO GITHUB USE: ssh -T git@github.com **********\n\033[0m"

# Since I didn't have ssh key access to github with the fresh install, git clone HTTPSurl had to be used. That makes the remote origin
# for that git repo the HTTPSurl, which would require github username and password every time I push to it. The previous lines set-up
# git-hub to use an SSH-key, so the below changes the remote origin for the cloned dotfiles repo to be the SSHurl (and thus utilize the key)
    cd dotfiles/
    git remote set-url origin git@github.com:dfeagans/dotfiles.git
    cd

# Deletes the script since it won't be needed anymore (and it's not linked to git, so no reason to keep it around to try to modify)
    rm $0
