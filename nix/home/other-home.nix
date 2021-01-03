{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ./generic ];
  home.file.".profile".text = lib.mkAfter ''
    # nix
    export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';

}
