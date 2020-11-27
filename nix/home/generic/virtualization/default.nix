{ pkgs, ... }: 
{ 
  home.packages = with pkgs; [ 
    kubectl 
    aws
    eksctl
    azure-cli
    google-cloud-sdk 
    kubernetes-helm
    istioctl 
    kind
  ]; 
}
