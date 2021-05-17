<div align="center">
<h1>dotfiles</h1>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-20.09-blue?style=for-the-badge&logo=NixOS&logoColor=white">
</a>
<img  src="https://img.shields.io/github/license/ttak0422/dotfiles?style=for-the-badge&color=black">
</div>

## About

実験中...

```
├── locals                  # local configs
└── nix                     ### nix ###
    ├── darwin              ## nix-darwin ##
    │   ├── system          # system configuration
    │   ├── tools           # some services that can only be defined in nix-darwin
    │   └── window-manager  # yabai
    ├── home                ## home-manager ##
    │   ├── dev             # python, go, ...
    │   ├── git             # git
    │   ├── nixos           # some package that can only be defined for nixos
    │   ├── scripts         # some scripts
    │   ├── shell           # bash, zsh, fish
    │   ├── tools           # cui
    │   └── virtualization  # docker, k8s, ...
    └── nixos               ## nixos ##
        ├── applications    # gui application
        │   └── vscode      # vscode
        ├── language        # ime, fonts, ...
        ├── networking      # network
        ├── services        # service
        │   └── xserver     # x window system
        ├── utils           # e.g. tlp
        └── virtualization  # docker, vm, ...
```

## Usage

### Linux

```bash
# home-manager
home-manager -f nix/home/home.nix switch  
```

### Darwin

```bash
# nix-darwin
darwin-rebuild -I darwin-config=./nix/darwin/desktop.nix switch 

# home-manager
home-manager -f nix/home/home.nix switch  
```

### ~~NixOS~~

```bash
# nixos
sudo nixos-rebuild -I nixos-config=./nix/nixos/thinkpad-extreme-configuration.nix switch

# home-manager
home-manager -f nix/home/nixos.nix switch  
```

## MEMO

### 参照

- [nix](https://nixos.org/manual/nix/stable/)

    ```bash
    # linux
    curl -L https://nixos.org/nix/install | sh
    
    # darwin
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
    ```

- [nix-darwin](https://github.com/LnL7/nix-darwin)

- [home-manager](https://github.com/nix-community/home-manager)

### 設定について

**git**

`locals/git.json`

```bash
{
    "name": "ttak0422",
    "email": "bgdaewalkman@gmail.com"
}
```
