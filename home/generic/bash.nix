{ config, pkgs, lib, ... }: {
  programs.bash = { enable = true; };
  home.file.".bashrc".text = lib.mkAfter "exec fish";

}
