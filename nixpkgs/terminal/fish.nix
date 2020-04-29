{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
        fish_prompt = "eval /home/tak/.nix-profile/bin/powerline-go -error $status -shell bare -modules venv,user,ssh,cwd,perms,git,hg,jobs,exit -newline";      
    };
    shellAbbrs = {
      "d" = "docker";
      "dc" = "docker-compose";      
    };
    shellAliases = {
      "g"  = ''cd (ghq root)'/'(ghq list | peco))'';
      "gh" = ''hub browse (ghq list | peco | cut -d "/" -f 2,3)'';
    };
  };
}
