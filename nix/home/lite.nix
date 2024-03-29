{ config, pkgs, lib, ... }: {
  imports = [
    ./applications
    ./dev/go.nix
    ./dev/js.nix
    ./dev/jvm.nix
    ./dev/python.nix
    ./dev/ruby.nix
    ./git
    ./scripts
    #    ./services
    ./shell
    ./tools
    #    ./virtualization
  ];
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home = {
    stateVersion = "21.05";
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
