{ config, pkgs, lib, ... }:
let
  wrap = txt: "'${txt}'";
  boolToString = b: if b then "true" else "false";
  updateChannel = "stable";
  fontSize = 20;
  fontFamily =
    ''"Hack Nerd Font", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace'';
  fontWeight = "normal";
  fontWeightBold = "bold";
  lineHeight = 1;
  letterSpacing = 0;
  cursorColor = "rgba(248,28,229,0.8)";
  cursorAccentColor = "#000";
  cursorShape = "BLOCK";
  cursorBlink = false;
  foregroundColor = "#fff";
  backgroundColor = "#000";
  selectionColor = "rgba(248,28,229,0.3)";
  borderColor = "#333";
  css = "";
  termCSS = "";
  showHamburgerMenu = true;
  showWindowControls = false;
  paddingX = 12;
  paddingY = 14;
  colors = {
    black = "#000000";
    red = "#C51E14";
    green = "#1DC121";
    yellow = "#C7C329";
    blue = "#0A2FC4";
    magenta = "#C839C5";
    cyan = "#20C5C6";
    white = "#C7C7C7";
    lightBlack = "#686868";
    lightRed = "#FD6F6B";
    lightGreen = "#67F86F";
    lightYellow = "#FFFA72";
    lightBlue = "#6A76FB";
    lightMagenta = "#FD7CFC";
    lightCyan = "#68FDFE";
    lightWhite = "#FFFFFF";
  };
  shell = "";
  shellArgs = [ "--login" ];
  bell = true;
  copyOnSelect = false;
  defaultSSHApp = true;
  quickEdit = false;
  macOptionSelectionMode = "vertical";
  webGLRenderer = true;
  plugins = [ 
    "hyper-iceberg"     # theme
    "hyperborder"
    "hyperlinks"        # url
    # "hyperterm-overlay" # overlay
  ];
  config = ''
    config: {
      updateChannel: ${wrap updateChannel},
      fontSize: ${toString fontSize},
      fontFamily: ${wrap fontFamily},
      fontWeight: ${wrap fontWeight},
      fontWeightBold: ${wrap fontWeightBold},
      lineHeight: ${toString lineHeight},
      letterSpacing: ${toString letterSpacing},
      cursorColor: ${wrap cursorColor},
      cursorAccentColor: ${wrap cursorAccentColor},
      cursorShape: ${wrap cursorShape},
      cursorBlink: ${boolToString cursorBlink},
      foregroundColor: ${wrap foregroundColor},
      backgroundColor: ${wrap backgroundColor},
      selectionColor: ${wrap selectionColor},
      borderColor: ${wrap borderColor},
      css: ${wrap css},
      termCSS: ${wrap termCSS},
      showHamburgerMenu: ${wrap ""},
      showWindowControls: ${wrap ""},
      padding: '${toString paddingX}px ${toString paddingY}px',
      colors: {
        black: ${wrap colors.black},
        red: ${wrap colors.red},
        green: ${wrap colors.green},
        yellow: ${wrap colors.yellow},
        blue: ${wrap colors.blue},
        magenta: ${wrap colors.magenta},
        cyan: ${wrap colors.cyan},
        white: ${wrap colors.white},
        lightBlack: ${wrap colors.lightBlack},
        lightRed: ${wrap colors.lightRed},
        lightGreen: ${wrap colors.lightGreen},
        lightYellow: ${wrap colors.lightYellow},
        lightBlue: ${wrap colors.lightBlue},
        lightMagenta: ${wrap colors.lightMagenta},
        lightCyan: ${wrap colors.lightCyan},
        lightWhite: ${wrap colors.lightWhite},
      },
      shell: ${wrap shell},
      shellArgs: [${lib.strings.concatMapStringsSep ", " wrap shellArgs}],
      env: {},
      bell: 'SOUND',
      copyOnSelect: ${boolToString copyOnSelect},
      defaultSSHApp: ${boolToString defaultSSHApp},
      quickEdit: ${boolToString quickEdit},
      macOptionSelectionMode: ${wrap macOptionSelectionMode},
      webGLRenderer: ${boolToString webGLRenderer},
      // hyperterm-overlay
      // overlay: {
      //   alwaysOnTop: false,
      //   animate: false,
      //   hasShadow: false,
      //   hotkeys: ["Control+Space"],
      //   resizable: true,
      //   startAlone: true,
      //   unique: true,
      //   hideDock: true
      // }
    }'';
in {
  # WIP 
  home.file.".hyper_nix.js".text = ''
    module.exports = {
      ${config},
      plugins: [${lib.strings.concatMapStringsSep ", " wrap plugins}],
      localPlugins: [],
      keymaps: {},
    };'';
}
