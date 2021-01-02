{ config, pkgs, lib, ... }:

let
  quote = x: ''"${x}"'';
  makeSnippet = { description, command, tag ? [ ], output ? "" }: ''
    [[snippets]]
        description = "${description}"
        command = "${command}"
        tag = [${lib.strings.concatStringsSep ", " (map quote tag)}]
        output = "${output}"
  '';
  config = ''
    [General]
        snippetfile = "${builtins.getEnv "HOME"}/.config/pet/snippets.toml"
        editor = "vim"
        column = 40
        selectcmd = "peco"
  '';
  snippets = lib.strings.concatMapStringsSep "\n" makeSnippet [{
    description = "ping";
    command = "ping 8.8.8.8";
    tag = [ "network" "google" ];
    output = "sample snippet";
  }];
in {
  home.packages = [ pkgs.peco pkgs.pet ];
  home.file.".config/pet/config.toml".text = config;
  home.file.".config/pet/snippets.toml".text = snippets;
}
