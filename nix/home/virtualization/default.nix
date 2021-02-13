{ config, pkgs, lib, ... }: {
  home.packages = with pkgs;
    [
      aws
      azure-cli
      eksctl
      google-cloud-sdk
      istioctl
      k9s
      kind
      kubectl
      kubectx
      kubernetes-helm
      stern
    ] ++ (if stdenv.isDarwin then [ minikube ] else [ ]);
}
