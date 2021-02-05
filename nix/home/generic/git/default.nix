{ config, pkgs, lib, ... }:
let
  name = "ttak0422";
  email = "bgdaewalkman@gmail.com";
  configDir = ".config/git";
  templateFile = "${configDir}/template";
  ignoreFile = "${configDir}/ignore";
  config = ''
    [core]
      autocrlf = false
      pager = less -r
      editor = vi
    [color]
      ui = auto
      autocrlf = false
    [push]
      default = current
    [user]
      name = ${name}
      email = ${email}
    [filter "lfs"]
      clean = git-lfs clean -- %f
      smudge = git-lfs smudge -- %f
      process = git-lfs filter-process
      required = true
    [commit]
      template = ~/${templateFile}
    [alias]
      ignore = !"f() { local s=$1; shift; \
        while [ $# -gt 0 ]; do s=\"$s,$1\"; shift; done;\
        curl -L \"https://www.gitignore.io/api/$s\"; }; f"
    [credential]
        helper = store
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

  tigrc = ''
    set main-view = id date author:email-user commit-title:graph=yes,refs=yes
    set main-view-date = custom
    set main-view-date-format = "%y/%m/%d %H:%M"
    set blame-view  = date:default author:email-user id:yes,color line-number:yes,interval=1 text
    set pager-view  = line-number:yes,interval=1 text
    set stage-view  = line-number:yes,interval=1 text
    set log-view    = line-number:yes,interval=1 text
    set blob-view   = line-number:yes,interval=1 text
    set diff-view   = line-number:yes,interval=1 text:yes,commit-title-overflow=no

    bind main R !git rebase -i %(commit)
    bind diff R !git rebase -i %(commit)
  '';
in {
  home = {
    packages = with pkgs; [ git tig ghq gitAndTools.gh ];
    file = {
      "${configDir}/config".text = config;
      "${configDir}/ignore".text = ignore;
      "${configDir}/template".text = template;
      ".tigrc".text = tigrc;
    };
  };
}
