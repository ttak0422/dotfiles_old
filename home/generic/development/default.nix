{ pkgs, ... }: {
  home.packages = with pkgs; [ dotnet-sdk_3 nodejs yarn rustup adoptopenjdk-jre-openj9-bin-13 ];
}
