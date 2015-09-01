#!/bin/bash

ubuntu/add_desktop_repositories.sh
ubuntu/add_server_repositories.sh

# Update sources
sudo apt-get update

# Install everything
ubuntu/install_server_utils.sh
ubuntu/install_desktop_utils.sh
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
