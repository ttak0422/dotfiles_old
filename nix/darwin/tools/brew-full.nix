{ config, pkgs, lib, ... }: {
  config.homebrew = {
    enable = true;
    global.brewfile = true;
    global.noLock = true;
    brews = [ "lunchy" ];
    taps = [ "homebrew/cask-fonts" ];
    casks = [
      "alacritty"
      "bitwarden"
      "firefox"
      "font-fira-code"
      "font-hack-nerd-font"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "slack"
      "visual-studio-code"
    ];
  };
}

