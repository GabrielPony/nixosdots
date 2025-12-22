{ config, pkgs, ... }:
let
  flavor = config.var.catppuccin.flavor;
  fcitx5-accent = config.var.catppuccin.fcitx5-accent;
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-pinyin-zhwiki
      librime
      fcitx5-rime
      qt6Packages.fcitx5-chinese-addons
    ];
  };
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Vertical Candidate List=False
    Font="MonaspiceAr Nerd Font 13"
    Theme=catppuccin-${flavor}-${fcitx5-accent}
  '';

  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=pinyin

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=pinyin
    Layout=

    [GroupOrder]
    0=Default
  '';
}
