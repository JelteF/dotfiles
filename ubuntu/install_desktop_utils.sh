#!/bin/bash
set -euxo pipefail
sudo snap remove firefox
sudo apt-get --yes --force-yes install firefox keepassxc insync wl-clipboard
sudo snap install telegram-desktop

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo dpkg --install curlpackage.deb
    rm curlpackage.deb
}

wezterm_version=20240203-110809-5046fc22

curl_deb https://github.com/wez/wezterm/releases/download/$wezterm_version/wezterm-$wezterm_version.Ubuntu22.04.deb
