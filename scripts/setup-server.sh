#!/usr/bin/env bash

set -Eeuo pipefail

# One-command server bootstrap for this dotfiles repository.
#
# The script is idempotent for the normal installation steps:
# - existing Homebrew formulae are left in place;
# - an existing dotfiles checkout is reused;
# - local.toml is intentionally regenerated from local-server.toml;
# - existing files rejected by Dotter are not overwritten;
# - already-installed tmux plugins are left in place.
#
# Usage from an existing checkout:
#   ~/.dotfiles/scripts/setup-server.sh
#
# The script can also be downloaded and run from another directory. In that
# case it clones DOTFILES_REPO into DOTFILES_DIR (unless those variables are
# supplied explicitly).

readonly SCRIPT_NAME="${0##*/}"
readonly DOTFILES_REPO="${DOTFILES_REPO:-git@github.com:ChenRuiwei/dotfiles.git}"
readonly NERD_FONT_NAME="${NERD_FONT_NAME:-JetBrainsMono}"
readonly NERD_FONT_VERSION="${NERD_FONT_VERSION:-v3.3.0}"

readonly -a BREW_FORMULAE=(
    btop
    dotter
    dust
    eza
    fd
    fish
    fzf
    gh
    git-delta
    htop
    lazygit
    neovim
    ripgrep
    starship
    tealdeer
    tmux
    tokei
    tree-sitter-cli
    unzip
    uv
    yazi
    zoxide
)

readonly -a BREW_CASKS=(
    claude-code
    codex
)

readonly -a BREW_TAPS=(
    anomalyco/tap
)

readonly -a BREW_TAP_FORMULAE=(
    anomalyco/tap/opencode
)

log() {
    printf '[%s] %s\n' "$SCRIPT_NAME" "$*"
}

warn() {
    printf '[%s] WARNING: %s\n' "$SCRIPT_NAME" "$*" >&2
}

die() {
    printf '[%s] ERROR: %s\n' "$SCRIPT_NAME" "$*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

script_repo_dir() {
    local script_dir
    script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    cd -- "$script_dir/.." && pwd -P
}

SCRIPT_REPO_DIR="$(script_repo_dir)"
if [[ -n "${DOTFILES_DIR:-}" ]]; then
    readonly DOTFILES_DIR
elif [[ -f "$SCRIPT_REPO_DIR/.dotter/global.toml" ]]; then
    readonly DOTFILES_DIR="$SCRIPT_REPO_DIR"
else
    readonly DOTFILES_DIR="$HOME/.dotfiles"
fi

BREW=""

find_brew() {
    local candidate

    if candidate="$(command -v brew 2>/dev/null)"; then
        printf '%s\n' "$candidate"
        return 0
    fi

    for candidate in \
        "${HOMEBREW_BIN:-}" \
        "$HOME/.linuxbrew/bin/brew" \
        "/home/linuxbrew/.linuxbrew/bin/brew" \
        "/opt/homebrew/bin/brew" \
        "/usr/local/bin/brew"; do
        if [[ -n "$candidate" && -x "$candidate" ]]; then
            printf '%s\n' "$candidate"
            return 0
        fi
    done

    return 1
}

ensure_homebrew() {
    local brew_line

    BREW="$(find_brew || true)"
    if [[ -z "$BREW" ]]; then
        command_exists curl || die "curl is required to install Homebrew"
        log "Homebrew not found; running the official installer"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        BREW="$(find_brew || true)"
    fi

    [[ -n "$BREW" ]] || die "Homebrew was not found after installation"

    # Export Homebrew's environment for the rest of this process without
    # depending on a fixed installation prefix.
    eval "$("$BREW" shellenv bash)"

    # Make Homebrew available to future Bash sessions, without duplicating an
    # existing shellenv line.
    brew_line="eval \"\$($BREW shellenv bash)\""
    if ! grep -Fq 'brew shellenv bash' "$HOME/.bashrc" 2>/dev/null; then
        printf '\n%s\n' "$brew_line" >> "$HOME/.bashrc"
        log "Added Homebrew shellenv to $HOME/.bashrc"
    fi

    log "Using Homebrew: $BREW"
}

install_formulae() {
    log "Installing Homebrew formulae"
    "$BREW" install "${BREW_FORMULAE[@]}"
}

install_casks() {
    log "Installing Homebrew casks"
    "$BREW" install --cask "${BREW_CASKS[@]}"
}

install_tap_formulae() {
    log "Installing Homebrew tap formulae"
    "$BREW" install "${BREW_TAP_FORMULAE[@]}"
}

ensure_dotfiles_checkout() {
    local parent_dir
    local first_entry

    if [[ -f "$DOTFILES_DIR/.dotter/global.toml" ]]; then
        log "Using existing dotfiles checkout: $DOTFILES_DIR"
        return
    fi

    if [[ -d "$DOTFILES_DIR/.git" ]]; then
        die "Existing Git repository does not look like the expected dotfiles repository: $DOTFILES_DIR"
    fi

    if [[ -e "$DOTFILES_DIR" ]]; then
        first_entry="$(find "$DOTFILES_DIR" -mindepth 1 -maxdepth 1 -print -quit)"
        [[ -z "$first_entry" ]] || die "Target directory is not empty: $DOTFILES_DIR"
    fi

    parent_dir="$(dirname -- "$DOTFILES_DIR")"
    mkdir -p "$parent_dir"
    log "Cloning dotfiles repository into $DOTFILES_DIR"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
}

install_nerd_font() {
    local font_dir="$HOME/.fonts/$NERD_FONT_NAME"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONT_VERSION/$NERD_FONT_NAME.zip"
    local zip_file

    command_exists curl || die "curl is required to download Nerd Fonts"
    command_exists unzip || die "unzip is required to install Nerd Fonts"

    if ! command_exists fc-cache; then
        log "fc-cache not found; installing fontconfig with Homebrew"
        "$BREW" install fontconfig
    fi
    command_exists fc-cache || die "fc-cache is required to refresh the font cache"

    zip_file="$(mktemp "${TMPDIR:-/tmp}/${NERD_FONT_NAME}.XXXXXX.zip")"
    log "Downloading $NERD_FONT_NAME Nerd Font"
    curl -fL --retry 3 --retry-delay 2 "$font_url" -o "$zip_file"

    mkdir -p "$font_dir"
    unzip -q -o "$zip_file" -d "$font_dir"
    rm -f "$zip_file"
    fc-cache -fv
    log "Installed Nerd Font files in $font_dir"
}

deploy_dotfiles() {
    [[ -f "$DOTFILES_DIR/.dotter/local-server.toml" ]] ||
        die "Missing server profile: $DOTFILES_DIR/.dotter/local-server.toml"

    log "Selecting the server Dotter profile"
    cp -- "$DOTFILES_DIR/.dotter/local-server.toml" "$DOTFILES_DIR/.dotter/local.toml"

    log "Deploying dotfiles"
    "$DOTFILES_DIR/scripts/deploy-dotter.sh"
}

update_tldr_cache() {
    command_exists tldr || die "tealdeer was not installed correctly"
    log "Updating tldr cache"
    tldr --update
}

install_tmux_plugins() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    local install_script="$tpm_dir/bin/install_plugins"

    if [[ ! -x "$install_script" ]]; then
        log "Installing TPM"
        mkdir -p "$(dirname -- "$tpm_dir")"
        if [[ -e "$tpm_dir" ]]; then
            die "TPM target exists but is not a usable TPM checkout: $tpm_dir"
        fi
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi

    [[ -x "$install_script" ]] || die "TPM install script not found: $install_script"

    # Reload the configuration only when a tmux server is already running.
    # The command-line TPM installer itself does not require a running server.
    if tmux list-sessions >/dev/null 2>&1; then
        tmux source-file "$HOME/.tmux.conf"
    fi

    log "Installing tmux plugins"
    "$install_script"
}

main() {
    log "Starting server setup"
    ensure_homebrew
    install_formulae
    install_casks
    install_tap_formulae
    ensure_dotfiles_checkout
    install_nerd_font
    deploy_dotfiles
    update_tldr_cache
    install_tmux_plugins
    log "Server setup completed"
}

main "$@"
