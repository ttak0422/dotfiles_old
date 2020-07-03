{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    powerline-go
  ];
  programs.fish = {
    enable = true;
    functions = {
        fish_prompt = "eval $HOME/.nix-profile/bin/powerline-go -error $status -shell bare -modules venv,user,ssh,cwd,perms,git,hg,jobs,exit -newline -modules-right aws, cwd, docker, docker-context, dotenv, duration, exit, git, gitlite, hg, host, jobs, kube, load, newline, nix-shell, node, perlbrew, perms, plenv, root, shell-var, shenv, ssh, svn, termtitle, terraform-workspace, time, user, venv, vgo";      
        # https://github.com/oh-my-fish/plugin-peco/blob/master/functions/peco_select_history.fish
        peco_select_history = ''
          if test (count $argv) = 0
           set peco_flags --layout=bottom-up
          else
           set peco_flags --layout=bottom-up --query "$argv"
          end

          history|peco $peco_flags|read foo

          if [ $foo ]
            commandline $foo
          else
            commandline ""
          end
        '';
        fish_user_key_bindings = "bind \\cr peco_select_history";
    };
    shellAbbrs = {
      "d" = "docker";
      "dc" = "docker-compose";      
    };
    shellAliases = {
      "g"  = ''cd (ghq root)'/'(ghq list | peco)'';
      "gh" = ''hub browse (ghq list | peco | cut -d "/" -f 2,3)'';
    };
  };
}
