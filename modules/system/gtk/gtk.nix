{ inputs, pkgs, ... }:
{
  imports = [ inputs.catppuccin-nix.homeManagerModules.catppuccin ];
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "Monaspace" "Noto" ]; })
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style.name = "gtk2";
  };

  gtk = {
    enable = true;
    # font = { name = config.stylix.fonts.serif.name; };

    # catppuccin = {
    #   enable = true;
    #   flavor = "mocha";
    #   accent = "pink";
    #   size = "standard";
    #   tweaks = [ "normal" ];
    # };

    iconTheme = {
      name = "Papirus-Light";
      package = pkgs.catppuccin-papirus-folders;
    };

    # theme = {
    #   name = "Catppuccin-Mocha-Standard-Lavender-Dark";
    #   package = pkgs.custom.catppuccin-gtk;
    # };

    # cursorTheme = {
    #   name = "Catppuccin-Latte-Lavender-Cursors";
    #   package = pkgs.catppuccin-cursors;
    # };
    #
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };

    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };

  };
}

