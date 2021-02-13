<div align="center">
<h1>dotfiles</h1>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/NixOS-21.05-blue?style=for-the-badge&logo=NixOS&logoColor=white">
</a>
<img  src="https://img.shields.io/github/license/ttak0422/dotfiles?style=for-the-badge&color=black">
</div>

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

# homebrew
cd brew
brew bundle
```

