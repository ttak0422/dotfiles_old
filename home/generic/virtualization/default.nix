{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    azure-cli
  ];
}
