#!/usr/bin/env bash

# help from:
#   https://gist.github.com/textarcana/5855427
#   http://tecadmin.net/install-firefox-on-linux/

yum install wget
yum install tar
# install deps
yum install -y java Xvfb firefox

# This version of FF doesn't actually work with latest selenium (for me) so I remove it again
# We initially install firefox with yum so all the deps are included
yum remove -y firefox

# get selenium server
wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar

# move it to a known location
mv selenium-server-standalone-2.53.0.jar /opt/selenium-server-standalone.jar

# install latest extended release FF
wget http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/45.0/linux-x86_64/en-US/firefox-45.0.tar.bz2
tar -xvjf firefox-45.0.tar.bz2
mv firefox /usr/local/firefox
ln -s /usr/local/firefox/firefox /usr/local/bin/firefox

# create a fake monitor
Xvfb :99 -ac -screen 0 1280x1024x24 &> /dev/null &
# export the environment var for Firefox
echo "export DISPLAY=:99" >> ~/.profile

# run the server
java -jar /opt/selenium-server-standalone.jar &> /dev/null &

# Ready to run behat tests

echo "done"