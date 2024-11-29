{ config, pkgs, ... }:

{
  # 安装 gedit
  home.packages = with pkgs; [
    gedit
  ];
}
