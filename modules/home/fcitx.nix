{ pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons # 中文输入支持
      fcitx5-configtool # 图形配置工具
      fcitx5-gtk # GTK 支持
      fcitx5-qt # Qt 支持
      fcitx5-material-color # 主题支持
    ];
  };

  xdg.configFile = {
    # Catppuccin Mocha 主题配置
    "fcitx5/conf/classicui.conf".text = ''
      # 垂直候选列表
      Vertical Candidate List=False

      # 按屏幕 DPI 使用
      PerScreenDPI=True
      # Font (设置字体)
      Font="JetBrainsMono Nerd Font 12"

      # 主题
      Theme=catppuccin-mocha

      # 字体 DPI
      FontDPI=120
    '';

    # 配置主题
    "fcitx5/themes/catppuccin-mocha".source = pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "fcitx5";
        rev = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
        sha256 = "sha256-uFaCbyrEjv4oiKUzLVFzw+UY54/h7wh2cntqeyYwGps=";
      } + "/src/catppuccin-mocha";
  };

  home.file = {
    # 默认输入法配置
    ".local/share/fcitx5/inputmethod".text = ''
      # 默认输入法
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
  };
}
