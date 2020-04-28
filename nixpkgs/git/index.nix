{ config, pkgs, lib, ... }:

let 
  name = "ttak0422";
  email = "bgdaewalkman@gmail.com";
  configDir = ".config/git";
  configFile = "${configDir}/config";
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
  '';
  template = ''
    
    
    # ==== Emojis ====
    #:bug: -------------- バグ修正
    #:+1: --------------- 機能改善
    #:sparkles: --------- 機能追加・小
    #:tada: ------------- 機能追加・大
    #:memo: ------------- ドキュメント・コメント（追加・更新）
    #:recycle: ---------- リファクタリング
    #:shower: ----------- 不要な機能・使われなくなった機能の削除
    #:shirt: ------------ Lintエラーの修正やコードスタイルの修正
    #:white_check_mark: - テストやCIの修正・改善
    #:rocket: ----------- パフォーマンス改善
    #:arrow_up_small: --- 依存パッケージなどのアップデート
    #:arrow_down_small: - 依存パッケージなどのダウングレード
    #:lock: ------------- 新機能の公開範囲の制限
    #:cop: -------------- セキュリティ関連の改善
    #:hankey: ----------- 糞コード
    #:construction: ----- WIP(Work In Progress)
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
in {
  imports = [
      ./tig.nix
  ];
  home.file.${configFile}.text = config;
  home.file.${templateFile}.text = template;
  home.file.${ignoreFile}.text = ignore;
}
