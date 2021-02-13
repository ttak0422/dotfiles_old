{ config, pkgs, lib, ... }: {
  # TODO fcitx-configtoolで一部設定が必要
  # Keyboard (Japanese), Mozc, ...
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
    };
  };
}
