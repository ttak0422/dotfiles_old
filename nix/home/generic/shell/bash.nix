{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ bash_5 powerline-go ];
  programs.bash = {
    enable = true;
  };
}
