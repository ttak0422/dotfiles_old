{ config, pkgs, lib, ... }:
let
  name = "ttak0422";
  email = "bgdaewalkman@gmail.com";
  configDir = ".config/git";
  secretsPath = ".config/git-secrets";
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
      templatedir = "~/${secretsPath}"
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
    [credential]
        helper = store
    [secrets]
        providers = git secrets --aws-provider
        patterns = (A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}
        patterns = (\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?
        patterns = (\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?
        allowed = AKIAIOSFODNN7EXAMPLE
        allowed = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
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
  secrets = {
    commit-msg = ''
      #!/usr/bin/env bash
      git secrets --commot_msg_hook -- "$@"
    '';
    pre-commit = ''
      #!/usr/bin/env bash
      git secrets --pre_commit_hook -- "$@"
    '';
    prepare_commit_msg = ''
      #!/usr/bin/env bash
      git secrets --prepare_commit_msg_hook -- "$@"
    '';
  };
in {
  home = {
    packages = with pkgs; [ git ghq gitAndTools.gh git-secrets ];
    file = {
      "${configDir}/config".text = config';
      "${configDir}/ignore".text = ignore;
      "${configDir}/template".text = template;
      "${secretsPath}/hooks/commit-msg".text = secrets.commit-msg;
      "${secretsPath}/hooks/pre-commit".text = secrets.pre-commit;
      "${secretsPath}/hooks/prepare-commit-msg".text = secrets.prepare_commit_msg;
    };
  };
}
