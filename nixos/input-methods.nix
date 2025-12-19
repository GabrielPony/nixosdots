{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-pinyin-zhwiki
      librime
      fcitx5-rime
      qt6Packages.fcitx5-chinese-addons
    ];
  };
}
