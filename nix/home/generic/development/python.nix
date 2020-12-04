{ pkgs, ... }: {
  home.packages = with pkgs; [
    python3
    python38Packages.pip
  ];
}