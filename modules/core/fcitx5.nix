{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      rime-data
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-nord
    ];
  };
}
