#!/bin/bash
set -euxo pipefail

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes install vim git python3-pip\
    htop python3-dev tig curl fish silversearcher-ag build-essential\
    tmux whois wget neovim cmake zlib1g-dev libncurses-dev gdb\
    shellcheck openssl libssl-dev pkg-config socat unzip python-is-python3 \
    libtool nodejs golang-1.21-go libffi-dev libbz2-dev libreadline-dev \
    libyaml-dev mold flex bison libxml2-dev libxslt1-dev \
    libzstd-dev liblz4-dev llvm-15-dev clang-15 libevent-dev libc-ares-dev \
    libsystemd-dev pandoc libcurl4-gnutls-dev libicu-dev uuid-dev \
    libkrb5-dev liblz4-dev libpam0g-dev libreadline-dev libselinux1-dev \
    libssl-dev libxslt1-dev libzstd-dev libipc-run-perl valgrind \
    xsltproc libxml2-utils docbook-xsl gettext bear


curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo dpkg --install curlpackage.deb
    rm curlpackage.deb
}

curl_deb https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
curl_deb https://github.com/sharkdp/fd/releases/download/v8.7.0/fd_8.7.0_amd64.deb
curl_deb https://github.com/dandavison/delta/releases/download/0.16.5/git-delta-musl_0.16.5_amd64.deb
curl_deb https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb
curl_deb https://github.com/cli/cli/releases/download/v2.32.1/gh_2.32.1_linux_amd64.deb

mkdir -p ~/.bin
curl --location https://github.com/starship/starship/releases/download/v1.16.0/starship-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin starship

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip

python -m pip install virtualfish
vf install auto_activation
