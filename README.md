<div align="center">
<h1>dotfiles</h1>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-21.05-blue?style=for-the-badge&logo=NixOS&logoColor=white">
</a>
<img  src="https://img.shields.io/github/license/ttak0422/dotfiles?style=for-the-badge&color=black">
</div>

![image](https://user-images.githubusercontent.com/15827817/124383528-e74c9f00-dd07-11eb-8565-e4a7b687f35a.png)

## About

実験中...

```
├── locals                  # local configs
└── nix                     ### nix ###
    ├── darwin              ## nix-darwin ##
    │   ├── system          # deck, finder, keyboard, ...
    │   ├── tools           # brew, lorri (for darwin), ...
    │   └── window-manager  # yabai, spacebar, skhd, ...
    └── home                ## home-manager ##
        ├── dev             # python, go, ...
        ├── git             # git
        ├── nixos           # about nixos
        ├── scripts         # some scripts
        ├── shell           # bash, zsh, fish
        ├── tools           # bat, exa, procs, ...
        └── virtualization  # docker, k8s, ...
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
darwin-rebuild -I darwin-config=./nix/darwin/full.nix switch     

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

### References

- [nix](https://nixos.org/manual/nix/stable/)

- [nix-darwin](https://github.com/LnL7/nix-darwin)

- [home-manager](https://github.com/nix-community/home-manager)

- [niv](https://github.com/nmattia/niv)

### local settings (wip...)

```bash
# git (locals/git.json)
{
    "name": "ttak0422",
    "email": "bgdaewalkman@gmail.com"
}
```
