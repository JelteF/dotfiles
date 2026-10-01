#!/bin/bash
# Set up a fresh Ubuntu server from these dotfiles: install packages, link
# the configs and make fish the login shell.
#
# --unattended makes sure nothing waits for input, for machines that are set
# up without anyone at a terminal (e.g. cloud-init on a new VM).

set -euxo pipefail

cd "$(dirname "$(readlink -f "$0")")"

if [ "${1:-}" = --unattended ]; then
    # Keep the locally installed version of changed config files instead of
    # asking. Passed through APT_CONFIG instead of an apt.conf.d file, so that
    # later interactive apt runs on this machine still ask.
    APT_CONFIG=$(mktemp)
    trap 'rm -f "$APT_CONFIG"' EXIT
    cat >"$APT_CONFIG" <<'EOF'
Dpkg::Options { "--force-confdef"; "--force-confold"; };
EOF
    export APT_CONFIG DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a

    # The install scripts call `sudo apt-get` all over the place and sudo
    # resets the environment, which would drop the variables above. An
    # exported function is inherited by the child bash scripts, so this
    # covers all of them without touching every sudo call.
    sudo() {
        command sudo --preserve-env=APT_CONFIG,DEBIAN_FRONTEND,NEEDRESTART_MODE "$@"
    }
    export -f sudo
fi

./install_ubuntu_server.sh
./setup.sh
nvim --headless -c 'luafile install_nvim_plugins.lua'

fish_path=$(command -v fish)
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$fish_path" ]; then
    sudo chsh -s "$fish_path" "$USER"
fi
