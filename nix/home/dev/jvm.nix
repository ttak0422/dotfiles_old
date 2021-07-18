{ config, pkgs, lib, ... }: { 
  home = {
    packages = with pkgs; [ maven ]; 
    file = {
      "jdk/openjdk11".source = pkgs.jdk11;
      "jdk/openjdk16".source = pkgs.jdk16;
      "jdk/scala".source = pkgs.scala;
    };
    sessionVariables = {
      PATH="$HOME/jdk/openjdk11/bin:$PATH";
      JAVA_HOME="$HOME/jdk/openjdk11/bin";
      JAVA_HOME="$HOME/jdk/openjdk11";
    };
  };
}
