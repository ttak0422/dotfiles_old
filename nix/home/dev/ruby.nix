{ config, pkgs, lib, ... }: { 
  home.packages = with pkgs; [ ruby_3_0 ]; 
#  programs.zsh.initExtraFirst = ''
#    rbenv() {
#        unfunction "$0"
#        source <(rbenv)
#        $0 "$@"
#    }
#  '';
}