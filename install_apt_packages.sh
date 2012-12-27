#!/bin/bash

# Sign Google certificate
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo \
    apt-key add -

# Add Google to sources
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee \
    /etc/apt/sources.list.d/google.list > /dev/null

# Update sources
sudo apt-get update

# Install everything
sudo apt-get --yes --force-yes install vim ack-grep git keepass2 python-pip\
    ruby-sass irssi htop ipython synapse xdotool mono-complete gnuplot pypy\
    python-dev encfs git-flow tig google-chrome-stable

# Add keepass plugins
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/KeePassHttp.dll -O /usr/lib/keepass2/KeePassHttp.dll
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/Newtonsoft.Json.dll -O /usr/lib/keepass2/Newtonsoft.Json.dll

# Upgrade all existing packeges to newest version
sudo apt-get --yes --force-yes upgrade

# Install extra python packages
pip install --user sqlalchemy

# Install all the LaTeX, but ask
sudo apt-get install texlive-*
