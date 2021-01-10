{ config, pkgs, lib, ... }:
let
  go-path = "${builtins.getEnv "HOME"}/go";
  ghq-path = "${builtins.getEnv "HOME"}/ghq";
  rc = ''
    export GOPATH=${go-path}:${ghq-path}
    export GO111MODULE=on
    PATH=$PATH:${go-path}/bin
  '';
in {
  home.packages = with pkgs; [ go ];
  home.file.".bashrc".text = lib.mkAfter rc;
  home.file.".zshrc".text = lib.mkAfter rc;
  home.file.".config/git/config".text = lib.mkAfter ''
    [ghq]
      root = ${go-path}/src
      root = ${ghq-path}/src
  '';
}
