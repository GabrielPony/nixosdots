{ uconfig, pkgs, lib, ... }:
let
  tmux-config = pkgs.callPackage ./../../pkgs/custom/tmux.nix { inherit uconfig; };
in
{
  home.packages = (with pkgs; [
    tmux
    xclip
    tmux-config
  ]);

  home.activation = {
    linkTmuxConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # 清理旧的链接（可选）
      $DRY_RUN_CMD rm -rf $HOME/.config/tmux
      $DRY_RUN_CMD mkdir -p $HOME/.config/tmux

      # 创建软链接
      $DRY_RUN_CMD ln -sf ${tmux-config}/config/.tmux.conf.local "$HOME/.config/tmux/tmux.conf.local"
      $DRY_RUN_CMD ln -sf ${tmux-config}/config/.tmux.conf "$HOME/.config/tmux/tmux.conf"
      #$DRY_RUN_CMD chmod 755 $HOME/.config/tmux/tmux.conf.local
    '';
  };

  # home.file.".config/tmux/tmux.conf.local".source = "${tmux-config}config/.tmux.conf.local";

}
