#!/usr/bin/env sh

cd $(dirname $(readlink -f $(which "$0")))/.. || exit 1

if [ ! -e .dotter/local.toml ] >/dev/null 2>&1; then
    echo "local.toml not exist"
    exit 1
fi

if ! command -v dotter >/dev/null 2>&1; then
    echo "dotter not found, trying to find rustup"
    if ! command -v rustup >/dev/null 2>&1; then
        echo "rustup not found, try the command below:"
        echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y"
        exit 1
    fi
    rustup toolchain install nightly
    cargo install dotter
fi

dotter deploy

if [ ! -e ~/.tmux/plugins/tpm ] >/dev/null 2>&1; then
    mkdir -p ~/.tmux/plugins/
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
