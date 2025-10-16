let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    git
    neovim
    lazygit
    ripgrep
    fd
    fzf
    zoxide
    dotter
    eza
    yazi
    tealdeer
    starship
    fish
  ];

  shellHook = ''
    echo "欢迎进入 Nix 开发环境！"
    fish
  '';
}
