{ config, pkgs, lib, ... }:
let
  nvim-config = pkgs.callPackage ./../../pkgs/custom/nvim.nix { inherit config; };
  shellAliases = {
    v = "nvim";
    vdiff = "nvim -d";
  };
in
{
  # 基础包安装
  home.packages = (with pkgs; [
    ripgrep
    gcc
    cargo
    lazygit
    unzip
    nodejs
    python3
    #
    lua-language-server    # Lua LSP
    nixpkgs-fmt           # Nix 格式化
    selene               # Lua 静态分析
    stylua               # Lua 格式化
    python312Packages.debugpy
    nodePackages.prettier # JavaScript/TypeScript/CSS/JSON 等格式化
    clang-tools          # C/C++ 格式化工具
    black                # Python 格式化
    nil                  # Nix LSP
    pyright               # Python LSP
  ]);

  # Shell 别名设置
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;

  # Neovim 主程序配置
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;

    # 编译环境配置
    extraWrapperArgs = with pkgs; [
      "--suffix"
      "LIBRARY_PATH"
      ":"
      "${lib.makeLibraryPath [stdenv.cc.cc zlib]}"

      "--suffix"
      "PKG_CONFIG_PATH"
      ":"
      "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" [stdenv.cc.cc zlib]}"
    ];

    # 核心插件
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      nvim-treesitter.withAllGrammars
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = "${nvim-config}/config/init.lua";
    "nvim/lua".source = "${nvim-config}/config/lua";
  };
}
