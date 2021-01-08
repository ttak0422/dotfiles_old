{ pkgs, shell-type ? "bash" }: {
  shellAliases = {
    "g" = if shell-type == "fish" then
      "cd (ghq root)'/'(ghq list | peco)"
    else
      "cd $(ghq root)/$(ghq list | peco)";
    "gg" = "ghq get";
    ".." = "cd ..";
    "top" = "btm";
    "ps" = "procs";
    "vi" = "${pkgs.vim}/bin/vim";
    "vim" = "nvim";
  };
  abbrevs = {
    static = {
      dk = "docker";
      ku = "kubectl";
      is = "istioctl";
      he = "helm";
      gc = "gcloud";
      dc = "docker-compose";
      ra = "ranger";
    };
    eval = { };
  };
}
