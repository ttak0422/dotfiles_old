let 
  sources = import ./nix/nix/sources.nix;
  nixpkgs = sources."nixpkgs";
  pkgs = import nixpkgs {};
in pkgs.mkShell rec {
  name = "dotfiles-shell";
  buildInputs = with pkgs; [
    niv 
    (import sources.home-manager {inherit pkgs;}).home-manager
  ];
  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${sources."home-manager"}"
  '';
}