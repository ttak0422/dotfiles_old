{ pkgs, ... }: {
  imports = [ ./js.nix ./python.nix ./go.nix ];
  home.packages = with pkgs; [
    coreutils-full
    dotnet-sdk_3
    rustup
    adoptopenjdk-jre-openj9-bin-13
    ruby_2_7
  ];
}
