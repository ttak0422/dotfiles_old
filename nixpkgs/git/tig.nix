{ config, pkgs, lib, ... }:

let 
  tigrc = ''
    bind main R !git rebase -i %(commit)
    bind diff R !git rebase -i %(commit)
  '';
in {
  home.packages = [ pkgs.tig ];
  home.file.".tigrc".text = tigrc;
}