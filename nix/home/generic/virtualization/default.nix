{ pkgs, ... }: 
{ 
  home.packages = with pkgs; [ 
    kubectl 
    kubectx
    aws
    eksctl
    azure-cli
    google-cloud-sdk 
    kubernetes-helm
    istioctl 
    kind
  ]; 
}
