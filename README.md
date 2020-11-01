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