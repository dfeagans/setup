# setup
AWS EC2 Instance Configuration Script - Installs Git, nvm/node/npm, and emacs
_____________________________________________________________________________

**Initial SSH Connection from Local Computer:**
- After creating a new Ubuntu instance on the AWS dashboard, make sure to download (or reuse an existing) public key during the AWS instance launch.
- Make the key NOT publicly visible to others using `chmod 400 KEYNAME.pem`. **REMEMBER: Public keys can't be visible to work.**
- Now you should be able to use `ssh -i KEYNAME.pem username@PUBLICIPorPUBLICDNS` to connect. The `-i` (identity file) option just means here's the full path to the key. If in doubt, on the AWS dashboard the instance was just launched from, right click the instance and click Connect. AWS will provide the verbatim commands.

**More Robust SSH Connection from Local Computer:**
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

**Creating New User Accounts on AWS Instance to SSH in with (Summary of AWS Docs [here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html)):**
- While ssh'd into the AWS instance, run `sudo adduser --disabled-password newUser` to create the new user. This command is saying: As superuser add a user named "newUser" and don't use a password (required to SSH into the AWS Ubuntu instance). A home directory named "userName" in the /home directory will automatically be created. The new home directory can be created using the `--home /home/otherName` option. Note that creates the directory, if you want to use an already created home directory look into the `--no-create-home` option.
- Change over to the new user using `sudo su - newuser`.
- In the new user's home directory, create a .ssh directory using `mkdir .ssh`, then make it so that only the owner can rear, write, and open it using `chmod 700 .ssh`.
- The final step is to add an authorized key so that the user's public key will be identified and approved. This is done using `touch .ssh/authorized_keys` to create the blank file and then running `chmod 600 .ssh/authorized_keys` to make it so that only the owner can read and write to the file. Finally paste the public key from the key pair into the authorized_keys file.
- To delete the user and their home directory, just use `sudo userdel olduser`. Adding the *-r* option will also remove their directory.
- For more info on the key pair process reference [here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair).
- Note that running anything on controlled ports requires root access, which the new user won't have. The new user can be added to the sudo group using `sudo usermod -a -G sudo newUser`. That's scorching the Earth, so it might be better to look into the visudo and sudoers.d file to give more limited access. On the AWS stuff (since the user was set-up with the --disabled-password option), it's necessary to set-up password-less sudo by adding `userName ALL=(ALL) NOPASSWD:ALL`to the appropriate file within /etc/sudoes.d (90-cloud-init-users for Ubuntu 14.04).

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
