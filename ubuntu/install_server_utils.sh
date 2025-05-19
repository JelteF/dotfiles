#!/bin/bash
set -euxo pipefail

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes install vim git python3-pip htop python3-dev tig curl fish \
    build-essential tmux whois wget cmake zlib1g-dev libncurses-dev \
    gdb shellcheck openssl libssl-dev pkg-config socat unzip python-is-python3 \
    libtool nodejs golang-1.21-go libffi-dev libbz2-dev libreadline-dev \
    libyaml-dev mold flex bison libxml2-dev libxslt1-dev \
    libzstd-dev liblz4-dev llvm-15-dev clang-15 libevent-dev libc-ares-dev \
    libsystemd-dev pandoc libcurl4-gnutls-dev libicu-dev uuid-dev \
    libkrb5-dev libpam0g-dev libreadline-dev libselinux1-dev \
    libssl-dev libxslt1-dev libzstd-dev libipc-run-perl valgrind \
    xsltproc libxml2-utils docbook-xsl gettext bear pipx ninja-build podman \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    isync libsasl2-modules-kdexoauth2 msmtp fzf

sudo snap install neovim

sudo usermod -aG docker $USER

pipx install meson

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo apt-get install -y ./curlpackage.deb
    rm curlpackage.deb
}

RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl_deb "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}-1_amd64.deb"
FD_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl_deb "https://github.com/sharkdp/fd/releases/latest/download/fd_${FD_VERSION}_amd64.deb"
DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl_deb "https://github.com/dandavison/delta/releases/latest/download/git-delta-musl_${DELTA_VERSION}_amd64.deb"
BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl_deb "https://github.com/sharkdp/bat/releases/latest/download/bat_${BAT_VERSION}_amd64.deb"
GH_VERSION=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl_deb "https://github.com/cli/cli/releases/latest/download/gh_${GH_VERSION}_linux_amd64.deb"

mkdir -p ~/.bin
curl --location https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin starship
SCCACHE_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sccache/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl --location https://github.com/mozilla/sccache/releases/latest/download/sccache-v${SCCACHE_VERSION}-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin "sccache-v${SCCACHE_VERSION}-x86_64-unknown-linux-musl/sccache" --strip-components 1

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl --location "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | tar xz --directory ~/.bin lazygit

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

pipx install virtualfish
fish -c "vf install auto_activation"
