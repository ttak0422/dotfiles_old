{ config, pkgs, lib, ... }: {
  config.homebrew = {
    enable = true;
    global.brewfile = true;
    global.noLock = true;
    brews = [ "lunchy" ];
    taps = [ "homebrew/cask-fonts" ];
    casks = [
      "alacritty"
      "cyberduck"
      "karabiner-elements"
      "font-hack-nerd-font"
      "font-fira-code"
      "keycastr"
      "visual-studio-code"
    ];
  };
}

