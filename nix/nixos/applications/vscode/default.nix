{ config, pkgs, lib, ... }:
let
  sources =
    import ./../../../sources.nix { sourcesFile = ./../../../vscode.json; };
  mkExt = name: src: {
    name = name;
    publisher = src.owner;
    version = src.version;
    sha256 = src.sha256;
  };
  extensions = (with pkgs.vscode-extensions;
    [
      # bbenoist.Nix
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      (mkExt "Nix" sources.Nix)
      (mkExt "path-intellisense" sources.path-intellisense)
      (mkExt "vim" sources.vim)
      (mkExt "bracket-lens" sources.bracket-lens)
    ];
  vscode-with-extensions =
    pkgs.vscode-with-extensions.override { vscodeExtensions = extensions; };
in { environment.systemPackages = [ vscode-with-extensions ]; }
