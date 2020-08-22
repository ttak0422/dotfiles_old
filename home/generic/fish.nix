{ config, pkgs, lib, ... }:

let sources = import ./../../nix/sources.nix;
in {
  home.packages = with pkgs; [ powerline-go ];
  programs.fish = {
    enable = true;
    functions = {
      fish_prompt =
        "eval (which powerline-go) -error $status -shell bare -modules venv,user,ssh,cwd,perms,git,hg,jobs,exit -newline";
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
    plugins = [
      # test
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
    ];
    shellAbbrs = {
      "d" = "docker";
      "dc" = "docker-compose";
      "k" = "kubectl";
    };
    shellAliases = {
      "g" = "cd (ghq root)'/'(ghq list | peco)";
      "gh" = ''hub browse (ghq list | peco | cut -d "/" -f 2,3)'';
      "gg" = "ghq get";
      "c" = "xclip -selection clipboard";
    };
  };

}
