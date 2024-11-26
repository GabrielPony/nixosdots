{ config, pkgs, ... }:

{
  # 安装 gedit
  home.packages = with pkgs; [
    gedit
  ];

  # GTK 主题设置
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "blue" ];
  #       variant = "mocha";
  #     };
  #   };
  # };
}

