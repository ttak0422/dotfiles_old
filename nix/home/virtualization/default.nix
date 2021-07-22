{ config, pkgs, lib, ... }: {
  home.packages = with pkgs;
    [
      awscli2
      azure-cli
      docui
      eksctl
      google-cloud-sdk
      istioctl
      k9s
      kind
      kubectl
      kubectx
      kubernetes-helm
      stern
      terraform
    ] ++ (if stdenv.isDarwin then [ minikube ] else [ ]);
}
