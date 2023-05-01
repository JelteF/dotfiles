#!/bin/bash
set -euxo pipefail

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes install vim git python3-pip\
    htop python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim cmake zlib1g-dev libncurses-dev gdb\
    shellcheck openssl libssl-dev pkg-config socat unzip python-is-python3 \
    libtool

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo dpkg --install curlpackage.deb
    rm curlpackage.deb
}

curl_deb https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
curl_deb https://github.com/sharkdp/fd/releases/download/v8.7.0/fd_8.7.0_amd64.deb
curl_deb https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb
curl_deb https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
curl_deb https://github.com/cli/cli/releases/download/v2.24.3/gh_2.24.3_linux_amd64.deb

mkdir -p ~/.bin
curl --location https://github.com/starship/starship/releases/download/v1.14.2/starship-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin starship

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip
