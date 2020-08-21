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
      editor = vim
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
  '';
in {
  home.file."${configDir}/config".text = config;
}