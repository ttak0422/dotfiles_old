# :construction: WIP :construction:

## About

```
├── cui              # CUI tools
├── dotfiles-private # 
├── gui              # GUI tools
├── home             # home-manager
├── hosts            # NixOS host
├── language         # Fonts & IME
├── networking       # Wi-Fi & Bluetooth
├── nix              # niv
├── services         # services such as xserver
├── utils            # something
└── virtualisation   # Docker & Kubernetes
```

## Usage

```bash
# nixos
$ sudo nixos-rebuild -I nixos-config=./hosts/ThinkPadX1Extreme/configuration.nix switch
$ home-manager -f ./home/nix-home.nix switch

# darwin
$ # wip

# other (install home-manager)
$ home-manager -f ./home/other-home.nix switch
```