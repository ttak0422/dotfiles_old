{ config, pkgs, lib, ... }:
let
  go-path = "${config.home.homeDirectory}/go";
  ghq-path = "${config.home.homeDirectory}/ghq";
in {
  home = {
    packages = with pkgs; [ go gore ];
    sessionVariables = {
      PATH = "$PATH:${go-path}/bin";
      GOPATH = "${go-path}:${ghq-path}";
      GO111MODULE = "on";
    };
    file.".config/git/config".text = lib.mkAfter ''
      [ghq]
        root = ${go-path}/src
        root = ${ghq-path}/src
    '';
  };
}
