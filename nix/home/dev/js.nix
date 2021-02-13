{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nodejs yarn nodePackages.node2nix ];
}
