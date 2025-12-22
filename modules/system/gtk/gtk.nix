{ config, pkgs, lib, ... }:
let
  flavor = config.var.catppuccin.flavor;
  accent = config.var.catppuccin.basic-accent;
in
{

   gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = flavor;
      gnomeShellTheme = true;
      icon.enable = true;
      icon.accent = accent;
      icon.flavor = flavor;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
