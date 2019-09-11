#!/bin/bash
# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim git python-pip python3-pip\
    htop python-dev python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb

sudo dpkg -i ripgrep_11.0.2_amd64.deb
rm ripgrep_11.0.2_amd64.deb
