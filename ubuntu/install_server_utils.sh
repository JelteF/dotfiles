#!/bin/bash
set -eux

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes --force-yes install vim git python3-pip\
    htop python-dev python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim cmake clang-tools-8 zlib1g-dev libncurses-dev gdb\
    shellcheck openssl libssl-dev pkg-config socat unzip

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo dpkg --install curlpackage.deb
    rm curlpackage.deb
}

curl_deb https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
curl_deb https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
curl_deb https://github.com/dandavison/delta/releases/download/0.12.1/git-delta-musl_0.12.1_amd64.deb
curl_deb https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
curl_deb https://github.com/cli/cli/releases/download/v2.9.0/gh_2.9.0_linux_amd64.deb

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip
