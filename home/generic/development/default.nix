{ pkgs, ... }: {
  home.packages = with pkgs; [ dotnet-sdk_3 nodejs yarn rustup ];
}
