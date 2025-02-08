#!/usr/bin/env bash

# Install basic tools
sudo apt install -y git curl make cmake gcc bzip2 fish zsh wget

# Install Nix
bash <(curl -L https://nixos.org/nix/install) --daemon
nix_config="if [ -e /data/home/ruiweichen/.nix-profile/etc/profile.d/nix.sh ]; then . /data/home/ruiweichen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer"
grep -Fq "$nix_config" .profile || echo "$nix_config" >>"$HOME"/.profile
source /etc/profile
source "$HOME"/.profile
if [ ! -d /etc/nix ]; then
    sudo mkdir -p /etc/nix
fi
echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf

# Install useful tools
nix-env -i dotter tmux neovim yazi lazygit eza zoxide fzf fd ripgrep tealdeer htop btop delta starship

# Download Nerd fonts
font="JetBrainsMono" # or Noto
if [ -e "$font".zip ]; then
    rm -f "$font".zip
fi
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/"$font".zip
mkdir -p ~/.fonts/"$font"
unzip "$font".zip -d ~/.fonts/"$font"
rm -f "$font".zip
fc-cache -fv

# Modify local.toml and then deploy dotfiles
git clone https://github.com/ChenRuiwei/dotfiles.git ~/.dotfiles
cp ~/.dotfiles/.dotter/{local-example,local}.toml
nvim ~/.dotfiles/.dotter/local.toml
~/.dotfiles/scripts/deploy-dotter.sh

# Do some init works
tldr --update
