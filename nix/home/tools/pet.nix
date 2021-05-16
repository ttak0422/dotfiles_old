# snippet manager
{ config, pkgs, lib, ... }:

with lib;

let
  makeSnippet = { description, command, tag ? [ ], output ? "" }: ''
    [[snippets]]
        description = "${description}"
        command = "${command}"
        tag = [${strings.concatStringsSep ", " (map (x: ''"${x}"'') tag)}]
        output = "${output}"
  '';
  config' = ''
    [General]
        snippetfile = "${config.home.homeDirectory}/.config/pet/snippets.toml"
        editor = "vim"
        column = 40
        selectcmd = "peco"
  '';
  snippets = strings.concatMapStringsSep "\n" makeSnippet [
    {
      description = "ping";
      command = "ping 8.8.8.8";
      tag = [ "network" "google" ];
      output = "sample snippet";
    }
    {
      description = "docker id - repositoty:tag";
      command = "docker images --format '{{.ID}} | {{.Repository}}:{{.Tag}}'";
      tag = [ "docker" ];
      output = "e.g. nix:1.0";
    }
    {
      description = "create local server";
      command = "python -m http.server 8080";
      tag = [ "python" "server" ];
      output = "simple server";
    }
    {
      description = "filter & map";
      command = "find . -name '*.foo' | xargs foo";
    }
    {
      description = "Dockernized Terraform";
      command =
        "docker run --rm -i -v $PWD:/work -w /work -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION hashicorp/terraform:0.14.8";
    }
  ];
in {
  home.packages = [ pkgs.peco pkgs.pet ];
  home.file.".config/pet/config.toml".text = config';
  home.file.".config/pet/snippets.toml".text = snippets;
  # bash todo
  # zsh
  home.file.".zshrc".text = mkAfter ''
    function pet-select() {
        BUFFER=$(pet search --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay
    }
    zle -N pet-select
    stty -ixon
    bindkey '^e' pet-select
  '';
  # fish
  programs.fish = {
    functions = {
      # https://github.com/otms61/fish-pet
      pet-select = ''
        set -l query (commandline)
        pet search --query "$query" $argv | read cmd
        commandline $cmd
      '';
      fish_user_key_bindings = "bind \\ce pet-select";
    };
  };

}
