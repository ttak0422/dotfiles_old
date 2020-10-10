# :construction: WIP :construction:

## About

```
├── cui              # CUI tools
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

- nixos

    ```bash
    $ sudo nixos-rebuild -I nixos-config=./hosts/ThinkPadX1Extreme/configuration.nix switch
    $ home-manager -f ./home/nix-home.nix switch
    ```

- darwin

    ```bash
    # install nix-darwin and home-manager
    $ darwin-rebuild -I darwin-config=hosts/macmini/darwin-configuration.nix switch
    $ home-manager -f ./home/other-home.nix switch
    ```

- other (install home-manager)

    ```bash
    $ home-manager -f ./home/other-home.nix switch
    ```