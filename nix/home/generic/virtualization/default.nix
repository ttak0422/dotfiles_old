{ pkgs, ... }: 
{ 
  home.packages = with pkgs; [ 
    kubectl 
    kubectx
    k9s
    stern
    aws
    eksctl
    azure-cli
    google-cloud-sdk 
    kubernetes-helm
    istioctl 
    kind
  ]++ (if stdenv.isDarwin then [
    minikube
  ] else []);
}
