#!/bin/bash

# PASSWORD=$1
# REPO="https://Daudongitlab:${PASSWORD}@gitlab.com/Daudongitlab/onprem.git"
# REPO="https://gitlab.com/Daudongitlab/onprem.git"
REPO="https://Daudongitlab:password@gitlab.com/Daudongitlab/onprem.git"

#install git
yum install -y git

#setup git
git config --global user.name "Daud"
git config --global user.email "daudonmail@gmail.com"

#from gitlab
# git config --global user.name "Oladipo Abiodun Dauda"
# git config --global user.email "daudonmail@gmail.com"

#clone your project
# git clone https://Daudongitlab:$PASSWORD@gitlab.com/Daudongitlab/onprem.git
git clone $REPO

cd onprem
# touch README.md
# git add README.md
# git commit -m "add README"


git checkout -b daud

data='<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>onprem</title>
</head>
<body>
    hello world
</body>
</html>'

touch index.html
echo "$data" > index.html

git add index.html
git commit -m"add index.html"
git push -u origin daud