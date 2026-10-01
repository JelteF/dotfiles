#!/bin/bash
set -euxo pipefail

# Install everything
echo 'Installing important stuff'
sudo apt-get --yes install vim git python3-pip htop python3-dev tig curl fish \
    build-essential tmux whois wget cmake zlib1g-dev libncurses-dev \
    gdb shellcheck openssl libssl-dev pkg-config socat unzip python-is-python3 \
    libtool nodejs golang libffi-dev libbz2-dev libreadline-dev \
    libyaml-dev mold flex bison libxml2-dev libxslt1-dev \
    libzstd-dev liblz4-dev llvm-dev clang libevent-dev libc-ares-dev \
    libsystemd-dev pandoc libcurl4-gnutls-dev libicu-dev uuid-dev \
    libkrb5-dev libpam0g-dev libreadline-dev libselinux-dev \
    libssl-dev libxslt1-dev libzstd-dev libipc-run-perl valgrind \
    xsltproc libxml2-utils docbook-xsl gettext bear pipx ninja-build podman \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    isync libsasl2-modules-kdexoauth2 msmtp fzf jq

sudo snap install nvim --classic

sudo usermod -aG docker $USER

pipx install meson

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo apt-get install -y ./curlpackage.deb
    rm curlpackage.deb
}

# Prints the tag of a GitHub repo's latest release. This follows the redirect
# of the releases/latest page instead of using api.github.com, whose
# unauthenticated rate limit of 60 requests per hour per IP is easily hit when
# rerunning this script, after which the versions silently come back empty.
latest_tag() {
    local url
    url=$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$1/releases/latest")
    echo "${url##*/tag/}"
}

RIPGREP_VERSION=$(latest_tag BurntSushi/ripgrep)
curl_deb "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}-1_amd64.deb"
FD_VERSION=$(latest_tag sharkdp/fd)
curl_deb "https://github.com/sharkdp/fd/releases/latest/download/fd_${FD_VERSION#v}_amd64.deb"
DELTA_VERSION=$(latest_tag dandavison/delta)
curl_deb "https://github.com/dandavison/delta/releases/latest/download/git-delta-musl_${DELTA_VERSION}_amd64.deb"
BAT_VERSION=$(latest_tag sharkdp/bat)
curl_deb "https://github.com/sharkdp/bat/releases/latest/download/bat_${BAT_VERSION#v}_amd64.deb"
GH_VERSION=$(latest_tag cli/cli)
curl_deb "https://github.com/cli/cli/releases/latest/download/gh_${GH_VERSION#v}_linux_amd64.deb"

mkdir -p ~/.bin
curl --location https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin starship
SCCACHE_VERSION=$(latest_tag mozilla/sccache)
SCCACHE_VERSION=${SCCACHE_VERSION#v}
curl --location https://github.com/mozilla/sccache/releases/latest/download/sccache-v${SCCACHE_VERSION}-x86_64-unknown-linux-musl.tar.gz | tar xz --directory ~/.bin "sccache-v${SCCACHE_VERSION}-x86_64-unknown-linux-musl/sccache" --strip-components 1

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

LAZYGIT_VERSION=$(latest_tag jesseduffield/lazygit)
LAZYGIT_VERSION=${LAZYGIT_VERSION#v}
curl --location "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | tar xz --directory ~/.bin lazygit

wget https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip
unzip -o npiperelay_windows_amd64.zip -d ~/npiperelay
rm npiperelay_windows_amd64.zip

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# The shell configs in this repo already put ~/.local/bin on the PATH, so
# don't let the installer append to them.
curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
