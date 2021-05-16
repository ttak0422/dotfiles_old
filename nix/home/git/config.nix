{ config, pkgs, lib, ... }:
let
  cfgFile = builtins.readFile (./. + "./../../../locals/git.json");
  cfgJSON = builtins.fromJSON cfgFile;
  name = cfgJSON.name;
  email = cfgJSON.email;
  configDir = ".config/git";
  config' = ''
    [core]
      autocrlf = false
      pager = less -r
      editor = vim
    [color]
      ui = auto
      autocrlf = false
    [push]
      default = current
    [user]
      name = ${name}
      email = ${email}
    [init]
      defaultBranch = "main"
    [filter "lfs"]
      clean = git-lfs clean -- %f
      smudge = git-lfs smudge -- %f
      process = git-lfs filter-process
      required = true
    [commit]
      template = ~/${configDir}/template
    [alias]
      ignore = !"f() { local s=$1; shift; \
        while [ $# -gt 0 ]; do s=\"$s,$1\"; shift; done;\
        curl -L \"https://www.gitignore.io/api/$s\"; }; f"
    [ghq]
      root = ~/src
  '';
  ignore = ''
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
  template = ''


    # ==== Emojis ====
    # 🎨 :art: when improving the format/structure of the code
    # 🐎 :racehorse: when improving performance
    # 🚱 :non-potable_water: when plugging memory leaks
    # 📝 :memo: when writing docs
    # 🐧 :penguin: when fixing something on Linux
    # 🍎 :apple: when fixing something on macOS
    # 🏁 :checkered_flag: when fixing something on Windows
    # 🐛 :bug: when fixing a bug
    # 🔥 :fire: when removing code or files
    # 💚 :green_heart: when fixing the CI build
    # ✅ :white_check_mark: when adding tests
    # 🔒 :lock: when dealing with security
    # ⬆️ :arrow_up: when upgrading dependencies
    # ⬇️ :arrow_down: when downgrading dependencies
    # 👕 :shirt: when removing linter warnings
  '';
in {
  home = {
    packages = with pkgs; [
      git
      ghq
      # gitAndTools.gh 
      # git-secrets 
    ];
    file = {
      "${configDir}/config".text = config';
      "${configDir}/ignore".text = ignore;
      "${configDir}/template".text = template;
    };
  };
}
