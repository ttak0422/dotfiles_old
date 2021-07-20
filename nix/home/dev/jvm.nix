{ config, pkgs, lib, ... }: { 
  home = {
    packages = with pkgs; [ scala maven ]; 
    file = {
      "jdk/openjdk8".source = pkgs.jdk8;
      "jdk/openjdk11".source = pkgs.jdk11;
      "jdk/openjdk16".source = pkgs.jdk16;
    };
    sessionVariables = {
      PATH="$HOME/jdk/openjdk11/bin:$PATH";
      JAVA_HOME="$HOME/jdk/openjdk11";
    };
  };
}
