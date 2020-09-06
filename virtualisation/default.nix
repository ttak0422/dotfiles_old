{ config, pkgs, lib, ... }: {
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
  environment.systemPackages = [
    pkgs.docker-compose
    # wip    
    pkgs.kubectl
    # $ minikube config set memory 8192
    # $ minikube config set cpus 2
    pkgs.minikube
  ];
}
