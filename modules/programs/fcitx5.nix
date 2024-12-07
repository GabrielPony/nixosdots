{ pkgs, lib, ... }:

let

  # 创建一个临时目录来存储所有 fcitx5 配置
  fcitx5-config = pkgs.runCommand "fcitx5-config" { } ''
    mkdir -p $out/conf

    # 创建 classicui.conf
    cat > $out/conf/classicui.conf << EOF
    Vertical Candidate List=False
    PerScreenDPI=True
    Font="JetBrainsMono Nerd Font 12"
    Theme=catppuccin-mocha
    DarkTheme=catppuccin-mocha
    FontDPI=120
    EOF

    # 创建 profile
    cat > $out/profile << EOF
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
    EOF

    # 创建 pinyin.conf
    cat > $out/conf/pinyin.conf << EOF
    PageSize=9
    ShowPreedit=True
    SpellEnabled=True
    EmojiEnabled=True
    CloudPinyinEnabled=True
    CloudPinyinIndex=2
    EOF

    # 创建 cloudpinyin.conf
    cat > $out/conf/cloudpinyin.conf << EOF
    Backend=Baidu
    EOF
  '';

  # 获取主题
  fcitx5-theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fcitx5";
    rev = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
    sha256 = "sha256-uFaCbyrEjv4oiKUzLVFzw+UY54/h7wh2cntqeyYwGps=";
  };

  # 创建主题配置
  fcitx5-themes = pkgs.runCommand "fcitx5-themes" { } ''
    mkdir -p $out
    cp -r ${fcitx5-theme}/src/* $out/
  '';
in
{
  # 创建只读的符号链接
  home.file.".config/fcitx5".source = fcitx5-config;
  home.file.".local/share/fcitx5/themes".source = fcitx5-themes;

  # 自动启动配置
  xdg.configFile."autostart/fcitx5.desktop".text = ''
    [Desktop Entry]
    Name=Fcitx 5
    GenericName=Input Method
    Comment=Start Input Method
    Exec=fcitx5 -d
    Icon=fcitx
    Terminal=false
    Type=Application
    Categories=System;Utility;
    StartupNotify=false
    X-GNOME-AutoRestart=false
    X-GNOME-Autostart-Phase=Applications
    X-KDE-autostart-after=panel
    X-KDE-autostart-phase=1
  '';
}
