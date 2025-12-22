{ config, pkgs, inputs, ... }:
let
  flavor = config.var.catppuccin.flavor;
  basic-accent = config.var.catppuccin.basic-accent;
  fcitx5-accent = config.var.catppuccin.fcitx5-accent;
  cursor-accent = config.var.catppuccin.cursor-accent;
in
{
  imports = [
    inputs.catppuccin-nix.homeModules.catppuccin
  ];

  home.file = {
    "Pictures/wallpapers/cat-leaves.png".source = inputs.nixy-wallpapers + "/wallpapers/cat-leaves.png";
  };

  catppuccin = {
    enable = true;    # 全局启用
    flavor = flavor;  # 推荐 mocha (深色)，还有 latte, frappe, macchiato
    accent = basic-accent;  # 强调色：lavender, mauve, blue 等
    lazygit.enable = true;
    fcitx5 = {
      enable = true;
      apply = false;
      flavor = flavor;
      accent = fcitx5-accent;
      enableRounded = true;
    };
    gtk.icon = {
      enable = true;
      accent = basic-accent;
      flavor = flavor;
    };

    chromium = {
      enable = true;
      flavor = flavor;
    };

    spotify-player.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    tmux.enable = true;
    waybar.enable = true;
    rofi.enable = true;

    cursors = {
      enable = true;
      flavor = flavor;
      accent = cursor-accent;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 32;
  };
}
