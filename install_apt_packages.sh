#!/bin/bash

# Sign Google certificate
echo 'Setting up Google Chrome stuff'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo \
    apt-key add -

# Add Google to sources
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee \
    /etc/apt/sources.list.d/google.list > /dev/null

# Update sources
sudo apt-get update

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim ack-grep git keepass2 python-pip\
    ruby-sass irssi htop ipython synapse xdotool mono-complete gnuplot pypy\
    python-dev encfs git-flow tig google-chrome-stable gparted skype wine\
    audacity

# Ask confirmation for games
echo 'Do you want to install games?'
sudo apt-get install openarena assaultcube

# Add keepass plugins
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/KeePassHttp.dll -O /usr/lib/keepass2/KeePassHttp.dll
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/Newtonsoft.Json.dll -O /usr/lib/keepass2/Newtonsoft.Json.dll

# Upgrade all existing packeges to newest version
echo 'Updating all packages'
sudo apt-get --yes --force-yes upgrade

# Install extra python packages
pip install --user sqlalchemy

# Install all the LaTeX, but ask
echo 'Do you really want ALL the LaTeX?'
sudo apt-get install texlive-*
