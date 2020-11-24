{ pkgs, ... }: {
  imports = [
    ./js.nix
  ];
  home.packages = with pkgs; [ 
    coreutils 
    dotnet-sdk_3 
    rustup 
    adoptopenjdk-jre-openj9-bin-13 
    ruby_2_7 
    python3
  ];
}
