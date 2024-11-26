{ uconfig, pkgs, lib,... }:
let
  nvim-config = pkgs.callPackage ./../../pkgs/custom/nvim.nix { inherit uconfig; };
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
    cargo
    lazygit
    nvim-config
  ]);

  home.activation = {
    linkNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p $HOME/.config/nvim
      $DRY_RUN_CMD chmod 755 $HOME/.config/nvim

      $DRY_RUN_CMD rm -rf $HOME/.config/nvim/*

      for file in ${nvim-config}/config/*; do
        $DRY_RUN_CMD ln -sf "$file" "$HOME/.config/nvim/$(basename $file)"
      done
    '';
  };
}
