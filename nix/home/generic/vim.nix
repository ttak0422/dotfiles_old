{ config, pkgs, lib, ... }: { 
    programs.vim.enable = true;
    programs.neovim = { enable = true; }; 
}
