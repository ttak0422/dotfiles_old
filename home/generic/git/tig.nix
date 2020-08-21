{ config, pkgs, lib, ... }: {
  home.packages = [ pkgs.tig ];
  home.file.".tigrc".text = ''
    bind main R !git rebase -i %(commit)
    bind diff R !git rebase -i %(commit)
  '';
}
