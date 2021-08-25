{ config, pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [ scala maven gradle kotlin ];
    file = {
      "jdk/adoptopenjdk8".source = pkgs.adoptopenjdk-openj9-bin-8;
      "jdk/adoptopenjdk11".source = pkgs.adoptopenjdk-openj9-bin-11;
      "jdk/adoptopenjdk16".source = pkgs.adoptopenjdk-openj9-bin-16;
    };
    sessionVariables = {
      PATH = "$HOME/jdk/adoptopenjdk11/bin:$PATH";
      JAVA_HOME = "$HOME/jdk/adoptopenjdk11";
    };
  };
}
