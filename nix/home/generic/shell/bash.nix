{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ bashInteractive_5 bash-completion ];
  programs.bash = { enable = true; };
  home.file.".bashrc".text = lib.mkAfter ''
    . ${pkgs.bash-completion}/share/bash-completion/bash_completion
  '';
}
