{ config, pkgs, lib, ... }: {
  # 可能な限りhomeで管理  
  environment.systemPackages = with pkgs; [ ];
}
