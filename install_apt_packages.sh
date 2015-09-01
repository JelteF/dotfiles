#!/bin/bash

# Sign Google certificate
echo 'Setting up Google Chrome stuff'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo \
    apt-key add -

# Add Google to sources
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee \
    /etc/apt/sources.list.d/google.list > /dev/null

# Add insync stuff
echo 'Setting up insync stuff'
wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key \
    | sudo apt-key add -

echo "deb http://apt.insynchq.com/ubuntu vivid non-free contrib" | sudo tee \
    /etc/apt/sources.list.d/insync.list > /dev/null

echo 'Setting up fish'
sudo apt-add-repository ppa:fish-shell/release-2

# Update sources
sudo apt-get update

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim ack-grep git keepass2 python-pip\
    ruby-sass irssi htop ipython synapse xdotool mono-complete gnuplot pypy\
    python-dev git-flow tig google-chrome-stable gparted insync curl fish

# Ask confirmation for games
echo 'Do you want to install games?'
sudo apt-get install openarena assaultcube

# Add keepass plugins
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx -O /usr/lib/keepass2/KeePassHttp.plgx
sudo chmod 644 /usr/lib/keepass2/KeePassHttp.plgx

# Upgrade all existing packeges to newest version
echo 'Updating all packages'
sudo apt-get --yes --force-yes upgrade

# Install all the LaTeX, but ask
echo 'Do you really want ALL the LaTeX?'
sudo apt-get install texlive-*
