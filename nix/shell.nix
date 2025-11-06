let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    bat
    btop
    delta
    dotter
    dust
    eza
    fd
    fish
    fzf
    git
    lazygit
    neovim
    nvitop
    ripgrep
    starship
    tealdeer
    tmux
    tree-sitter
    tokei
    yazi
    zoxide
  ];

  shellHook = ''
    echo "欢迎进入 Nix 开发环境！"
  '';
}
