{ config, pkgs, lib, ... }:
{
  home.file.".config/git/ignore".text = ''
    *~
    .DS_Store
    Thumbs.db
    Thumbs.db:encryptable
    .idea
    .vscode/*
    !.vscode/settings.json
    !.vscode/tasks.json
    !.vscode/launch.json
    !.vscode/extensions.json
    *.code-workspace
    .ionide
    .vs  
  '';
}