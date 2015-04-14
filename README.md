# setup
AWS EC2 Instance Configuration Script - Installs Git, nvm/node/npm, and emacs

**Initial SSH Connection**:
- After creating a new Ubuntu instance on the AWS dashboard, make sure to download (or reuse an existing) public key during the AWS instance launch.
- Make the key NOT publicly visible to others using *chmod 400 KEYNAME.pem*.
- Now you should be able to use *ssh -i KEYNAME.pem username@PUBLICIPorPUBLICDNS* to connect. The -i (identity file) option just means here's the full path to the key. If in doubt, right click the instance and click Connect. AWS will provide the verbatim commands. It's better to use a SSH config file to do this though (Reference my SSH Evernote for more info).

**Dotfiles Configuration and Github Connection**: 
The setup.sh in this folder is intended to come as close as possible to completely setting up a new AWS EC2 Ubuntu instance by running:

```
wget https://raw.githubusercontent.com/dfeagans/setup/master/setup.sh
chmod 700 setup.sh                  # Make script executable for user
./setup.sh                          # Run script
source .bash_profile                # Loads newly modified bash configs
```

The source .bash_profile can't be done in the script, because then it would only run for the shell instance in which the script is running, not the shell instance of the terminal.
