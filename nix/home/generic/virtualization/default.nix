{ pkgs, ... }: 
{ 
  home.packages = with pkgs; [ 
    kubectl 
    azure-cli
    google-cloud-sdk 
    kubernetes-helm
    istioctl 
    kind
  ]; 
}
