### add user to the docker group
    sudo usermod -aG docker $USER

### change nixos-config paths
```
sudo nixos-rebuild -I nixos-config=./hosts/umpc/configuration.nix switch
```

### channels
sudo nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update