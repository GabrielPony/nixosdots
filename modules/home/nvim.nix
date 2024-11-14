{ config, pkgs, lib, ... }:

let
  nvim-config = pkgs.callPackage ./../../pkgs/customnvim/default.nix {};
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
  ]);

  home.file.".config/nvim".source = "${nvim-config}/config";
}
