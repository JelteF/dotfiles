#!/bin/bash
set -euxo pipefail

# Set up firefox deb repo
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

# Add keepassxc
sudo add-apt-repository ppa:phoerious/keepassxc -y

# Add insync stuff
sudo wget -O /etc/apt/trusted.gpg.d/insynchq.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xAEEB94E9C5A3B54ECFA4A66AA684470CACCAF35C"
echo "deb http://apt.insync.io/ubuntu $(lsb_release -cs) non-free contrib" | sudo tee \
     /etc/apt/sources.list.d/insync.list > /dev/null

# Add vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
