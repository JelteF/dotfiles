#!/bin/bash
set -euxo pipefail

gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'

sudo snap disable firefox
sudo snap remove firefox
sudo apt-get --yes --force-yes install firefox keepassxc insync code
sudo snap install telegram-desktop discord slack

sudo tee /etc/apt/preferences.d/firefox-no-snap >/dev/null <<EOF
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

sudo tee /etc/apt/preferences.d/mozillafirefoxppa >/dev/null <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
EOF

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox >/dev/null

curl_deb() {
    curl --location --output curlpackage.deb "$1"
    sudo apt install -y ./curlpackage.deb
    rm curlpackage.deb
}

wezterm_version=nightly

curl_deb https://github.com/wez/wezterm/releases/download/$wezterm_version/wezterm-$wezterm_version.Ubuntu24.04.deb
