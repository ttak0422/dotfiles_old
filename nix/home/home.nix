{ config, pkgs, lib, ... }: {
  imports = [ ./dev ./git ./scripts ./shell ./tools ./virtualization ];
  nixpkgs.config.allowUnfree = true;
  home = {
    stateVersion = "20.09";
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    sessionVariables = {
        # sort by name
        # Foo, Bar, Baz -> Bar,Baz, Foo
    };
    file.".profile".text = lib.mkAfter ''
      source ~/.nix-profile/etc/profile.d/nix.sh
    '';
  };
}