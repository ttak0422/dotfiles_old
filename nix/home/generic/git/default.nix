{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ git tig ghq gitAndTools.hub ];
  imports = [ ./config.nix ./template.nix ./ignore.nix ./tig.nix ];
}
