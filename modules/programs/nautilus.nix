{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    nautilus
    nautilus-open-any-terminal # 强烈推荐：在 Nautilus 右键菜单中添加“在终端打开”
  ];
}

