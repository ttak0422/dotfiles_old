{ config, lib, ... }: {
  services.xserver = {
    videoDrivers = [ "displaylink" ];
  };
}