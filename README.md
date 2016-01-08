# setup
AWS EC2 Instance Configuration Script - Installs Git, nvm/node/npm, and emacs
_____________________________________________________________________________

**Initial SSH Connection**:
- After creating a new Ubuntu instance on the AWS dashboard, make sure to download (or reuse an existing) public key during the AWS instance launch.
- Make the key NOT publicly visible to others using `chmod 400 KEYNAME.pem`. **REMEMBER: Public keys can't be visible to work.**
- Now you should be able to use `ssh -i KEYNAME.pem username@PUBLICIPorPUBLICDNS` to connect. The `-i` (identity file) option just means here's the full path to the key. If in doubt, on the AWS dashboard the instance was just launched from, right click the instance and click Connect. AWS will provide the verbatim commands.

**More Robust SSH Connection**:
- The easiest method to ssh in regularly uses the SSH config method. This allows you to simply type `ssh aws` to connect. Creating one is easy:
- First, create a folder called ".ssh" in your home directory on *your local machine*. `mkdir .ssh`. 
- Then, set the proper permissions and cd into the .ssh folder: `chmod 700 .ssh` then
`cd .ssh`.
- Then, create a file called "config" that contains the following 
```
Host aws
    HostName ec2-00-00-00-00-us-west-2.compute.amazonaws.com
    User ubuntu
    IdentityFile ~/.ssh/aws.pem
```
- Note that in the above "config" file you can manage multiple Host entries. The HostName stuff is just random data in the example above. IdentifyFile points towards the .pem file in whatever directory is required. For more information, check out `man ssh_config`.
- Finally, make the file read/write only for yourself: `chmod 600 config`.

_____________________________________________________________________________
**Dotfiles Configuration and Github Connection:**

The setup.sh in this folder is intended to come as close as possible to completely setting up a new AWS EC2 Ubuntu instance by running:

```
wget https://raw.githubusercontent.com/dfeagans/setup/master/setup.sh
chmod 700 setup.sh                  # Make script executable for user
./setup.sh                          # Run script
source .bash_profile                # Loads newly modified bash configs
```

The source .bash_profile can't be done in the script, because then it would only run for the shell instance in which the script is running, not the shell instance of the terminal.
