{ shell-type ? "bash" }:
{
  shellAliases = {
    "g" = 
      if shell-type == "fish"
      then "cd (ghq root)'/'(ghq list | peco)"
      else "cd $(ghq root)/$(ghq list | peco)";
    "gh" =
      if shell-type == "fish"
      then ''hub browse (ghq list | peco | cut -d "/" -f 2,3)''
      else ''hub browse $(ghq list | peco | cut -d "/" -f 2,3)''; 
    "gg" = "ghq get";
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
    eval = {
    };
  };
}
