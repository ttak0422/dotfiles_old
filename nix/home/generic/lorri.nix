{ config, pkgs, ... }:

{
  services = if pkgs.stdenv.isLinux then {
    lorri.enable = true;
  }
  # nix-darwin
  else
    { };
  home.packages = with pkgs; [ direnv ];
  programs.fish = {
    shellInit = ''
      eval (direnv hook fish)
    '';
  };
}
