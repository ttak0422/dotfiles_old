{ config, pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;

  extensions = (with pkgs.vscode-extensions;
    [
      # bbenoist.Nix
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Nix";
        publisher = sources.Nix.owner;
        version = sources.Nix.version;
        sha256 = sources.Nix.sha256;
      }
      {
        name = "path-intellisense";
        publisher = sources.path-intellisense.owner;
        version = sources.path-intellisense.version;
        sha256 = sources.path-intellisense.sha256;
      }
      {
        name = "vim";
        publisher = sources.vim.owner;
        version = sources.vim.version;
        sha256 = sources.vim.sha256;
      }
    ];
  vscode-with-extensions =
    pkgs.vscode-with-extensions.override { vscodeExtensions = extensions; };
in { environment.systemPackages = [ vscode-with-extensions ]; }
