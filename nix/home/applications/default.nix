# アプリの設定ファイル群
{ config, pkgs, lib, ... }: {
  imports = [ ./alacritty.nix ./hyper.nix ];
}
