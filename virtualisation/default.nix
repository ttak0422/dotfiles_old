{ config, pkgs, lib, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };
  environment.systemPackages = [
    pkgs.docker-compose
    # wip    
    pkgs.kubectl  
  ];
}
