<div align="center">
<h1>dotfiles</h1>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-20.09-blue?style=for-the-badge&logo=NixOS&logoColor=white">
</a>
<img  src="https://img.shields.io/github/license/ttak0422/dotfiles?style=for-the-badge&color=black">
</div>

## About

```
nix
├── cui            # CUI tools
├── gui            # GUI tools
├── home           # home-manager
├── hosts          # NixOS & darwin host configurations
├── language       # Fonts & IME
├── networking     # Wi-Fi & Bluetooth
├── nix            # niv
├── services       # xserver, tlp, ...
├── virtualisation # vm, docker, k8s, ...
└── utils          # wip
```

## Usage

- nixos

    ```bash
    # install home-manager
    $ sudo nixos-rebuild -I nixos-config=./nix/hosts/ThinkPadX1Extreme/configuration.nix switch
    $ home-manager -f ./nix/home/nix-home.nix switch
    ```

- darwin

    ```bash
    # install nix-darwin and home-manager
    $ darwin-rebuild -I darwin-config=./nix/hosts/macmini/darwin-configuration.nix switch
    $ home-manager -f ./nix/home/other-home.nix switch
    ```

- other (Ubuntu, ...)

    ```bash
    # install home-manager
    $ home-manager -f ./nix/home/other-home.nix switch
    ```