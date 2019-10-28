#!/bin/bash
# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim git python-pip python3-pip\
    htop python-dev python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim cmake clang-tools-8 zlib1g-dev libncurses-dev gdb\
    shellcheck

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb

sudo dpkg -i ripgrep_11.0.2_amd64.deb
rm ripgrep_11.0.2_amd64.deb

curl -LO https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb
sudo dpkg -i fd_7.4.0_amd64.deb
rm fd_7.4.0_amd64.deb
