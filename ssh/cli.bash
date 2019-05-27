
#generate ssh private and public key
ssh-keygen -t rsa

#add Identity
ssh-add ~/.ssh/id_rsa

#use this if 
#add identity command (ssh-add ~/.ssh/id_rsa) give
#Could not open a connection to your authentication agent.
eval `ssh-agent -s` #(then ssh-add ~/.ssh/id_rsa again)

#To generate key for other company or app
# note "~" sign mean home or user directory
cd ~/.ssh
ssh-keygen -t rsa -C "companyName" -f "companyName"
ssh-add ~/.ssh/companyName

#create new ssh config file
touch ~/.ssh/config

#sample ssh config file content for github and bitbucket
Host bitbucket.org
  HostName bitbucket.org
  IdentityFile ~/.ssh/id_rsa

Host companyname.bitbucket.org
  HostName bitbucket.org
  IdentityFile ~/.ssh/companyName

Host github.com
  HostName github.com
  IdentityFile ~/.ssh/id_rsa

Host companyname.github.com
  HostName github.com
  IdentityFile ~/.ssh/companyName

#use this to view the public key(change id_rsa.pub for the specific public key)
#copy the key to github or bitbucket ssh key setting
cat ~/.ssh/id_rsa.pub


