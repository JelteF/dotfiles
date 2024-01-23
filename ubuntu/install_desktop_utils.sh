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

curl_deb https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
