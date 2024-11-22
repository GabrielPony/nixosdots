{ config, pkgs, lib, ... }:

let
  nvim-config = pkgs.callPackage ./../../pkgs/custom/nvim.nix {};
in
{
  programs.neovim = {
    enable = true;

    # 安装必要的依赖包
    extraPackages = with pkgs; [
      git
      nodejs
      ripgrep
      fd
      tree-sitter
      nodePackages.typescript
      nodePackages.typescript-language-server
      lua-language-server
      nil # Nix LSP
    ];
  };

  home.packages = (with pkgs; [
    nvim-config
    gcc
    unzip
  ]);

  home.activation = {
  linkNvimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # 创建目标目录（如果不存在）并设置权限
    $DRY_RUN_CMD mkdir -p $HOME/.config/nvim
    $DRY_RUN_CMD chmod 755 $HOME/.config/nvim

    # 清理旧的链接（可选）
    $DRY_RUN_CMD rm -rf $HOME/.config/nvim/*

    # 创建软链接
    for file in ${nvim-config}/config/*; do
      $DRY_RUN_CMD ln -sf "$file" "$HOME/.config/nvim/$(basename $file)"
    done
  '';
  };
}
