{ config, pkgs, lib, ... }:
{
  home.file.".config/git/template".text = ''

  
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
    #:rocket ------------ パフォーマンス改善
    #:arrow_up_small: --- 依存パッケージなどのアップデート
    #:arrow_down_small: - 依存パッケージなどのダウングレード
    #:lock: ------------- 新機能の公開範囲の制限
    #:cop: -------------- セキュリティ関連の改善
    #:hankey: ----------- 糞コード
    #:construction: ----- WIP(Work In Progress)
  '';
}