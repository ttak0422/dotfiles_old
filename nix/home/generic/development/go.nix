{ config, pkgs, lib, ... }: 
let 
  PATH="${builtins.getEnv "HOME"}/go";
in {
  home.packages = with pkgs; [
    go
  ];
  home.file.".bashrc".text = lib.mkAfter ''
    export GOPATH=${PATH}
  '';
}
