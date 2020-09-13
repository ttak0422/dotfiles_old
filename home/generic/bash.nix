{ config, pkgs, lib, ... }: {
  programs.bash = { enable = true; };

  programs.bash.bashrcExtra = ''
    if type "fish" > /dev/null 2>&1; then
      exec fish
    fi
  '';
}
