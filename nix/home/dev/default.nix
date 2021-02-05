{ pkgs, ... }: {
  imports = [ ./js.nix ./python.nix ./go.nix ];
  home.packages = with pkgs; [
    adoptopenjdk-jre-openj9-bin-13
    dotnet-sdk_3
    grpcui
    grpcurl
    protobuf
    ruby_2_7
    rustup
  ];
}
