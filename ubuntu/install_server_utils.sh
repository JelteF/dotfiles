#!/bin/bash
set -eux

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
curl_deb https://github.com/sharkdp/fd/releases/download/v8.4.0/fd_8.4.0_amd64.deb
curl_deb https://github.com/dandavison/delta/releases/download/0.13.0/git-delta-musl_0.13.0_amd64.deb
curl_deb https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb
curl_deb https://github.com/cli/cli/releases/download/v2.14.3/gh_2.14.3_linux_amd64.deb

mkdir -p ~/.bin
curl --location https://github.com/starship/starship/releases/download/v1.8.0/starship-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin starship

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip
