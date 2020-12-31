{ config, pkgs, lib, ... }:
let
  go-path = "${builtins.getEnv "HOME"}/go";
  ghq-path = "${builtins.getEnv "HOME"}/ghq";
in {
  home.packages = with pkgs; [ go ];
  home.file.".bashrc".text = lib.mkAfter ''
    export GOPATH=${go-path}:${ghq-path}
    export GO111MODULE=on
  '';
  home.file.".config/git/config".text = lib.mkAfter ''
    [ghq]
      root = ${go-path}/src
      root = ${ghq-path}/src
  '';
}
