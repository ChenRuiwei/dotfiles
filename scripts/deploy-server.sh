#!/usr/bin/env sh

cd $(dirname $(readlink -f $(which "$0")))/.. || exit 1

if [ ! -f ~/nix-portable ]; then
    echo "Downloading nix-portable..."
    wget -O ~/nix-portable https://github.com/DavHau/nix-portable/releases/download/v012/nix-portable-x86_64
    chmod +x ~/nix-portable
else
    echo "nix-portable already exists, skipping download"
fi

if ! command -v dotter >/dev/null 2>&1; then
    echo "dotter not found, trying to find rustup"
    if ! command -v rustup >/dev/null 2>&1; then
        echo "rustup not found, try the command below:"
        echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y
    fi
    rustup toolchain install nightly
    cargo install dotter
fi

cp .dotter/local-server.toml .dotter/local.toml
dotter deploy

if [ ! -e ~/.tmux/plugins/tpm ] >/dev/null 2>&1; then
    mkdir -p ~/.tmux/plugins/
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

cd ~ || exit 1
~/nix-portable nix-shell --command 'fish'
