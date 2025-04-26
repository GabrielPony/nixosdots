{ inputs, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors-white";
      # package = pkgs.catppuccin-cursors;
      # name = "mochaMauve";
      size = 24;

    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.monaspace;
        name = "Monospice Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-sans;
        name = "Source Sans";
      };
      serif = {
        package = pkgs.source-serif;
        name = "Source Serif";
      };
      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 11;
        popups = 11;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
    targets = {
      grub = {
        enable = true;
        useWallpaper = false;
      };
      gnome.enable = true;
      gtk.enable = true;
      spicetify.enable = true;
      nixos-icons.enable = true;
    };

    image = inputs.nixy-wallpapers + "/wallpapers/cat-leaves.png";
  };
}
