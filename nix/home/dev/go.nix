{ config, pkgs, lib, ... }:
let
  go-path = "${builtins.getEnv "HOME"}/go";
  ghq-path = "${builtins.getEnv "HOME"}/ghq";
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
