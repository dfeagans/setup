# setup
AWS EC2 Instance Configuration Script - Installs Git, nvm/node/npm, and emacs

The setup.sh in this folder is intended to come as close as possible to completely setting up a new AWS EC2 Ubuntu instance by running:

```
wget https://raw.githubusercontent.com/dfeagans/setup/master/setup.sh
chmod 700 setup.sh                  # Make script executable for user
./setup.sh                          # Run script
source .bash_profile                # Loads newly modified bash configs
```

The source .bash_profile can't be done in the script, because then it would only run for the shell instance in which the script is running, not the shell instance of the terminal.
