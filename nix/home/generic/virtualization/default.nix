{ pkgs, ... }: 
{ 
  home.packages = with pkgs; [ 
    kubectl 
    kubectx
    stern
    aws
    eksctl
    azure-cli
    google-cloud-sdk 
    kubernetes-helm
    istioctl 
    kind
  ]; 
}
