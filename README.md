# setup
AWS EC2 Instance Configuration Script - Installs Git, nvm/node/npm, and emacs

The setup.sh in this folder is intended to come as close as possible to completely setting up a new AWS EC2 Ubuntu instance by running:

```
wget https://raw.githubusercontent.com/dfeagans/setup/master/setup.sh
chmod 700 setup.sh                  # Make script executable for user
./setup.sh                          # Run script
rm setup.sh                         # Delete setup script
source .bash_profile                # Loads newly modified bash configs
```

As time goes on, this configuration will contain more and more detail. The comments in the setup.sh outline all the items I plan on configuring, but the actual commands will be added over time.
