#!/bin/bash
set -eux

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim git python-pip python3-pip\
    htop python-dev python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim cmake clang-tools-8 zlib1g-dev libncurses-dev gdb\
    shellcheck

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo dpkg --install curlpackage.deb
    rm curlpackage.deb
}

curl_deb https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
curl_deb https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
curl_deb https://github.com/dandavison/delta/releases/download/0.3.0/git-delta_0.3.0_amd64.deb
curl_deb https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
