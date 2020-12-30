{ pkgs, ... }: {
  home.packages = with pkgs; [ nodejs yarn nodePackages.node2nix ];
}
