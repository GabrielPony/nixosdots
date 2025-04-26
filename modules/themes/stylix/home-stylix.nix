{ pkgs, lib, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkDefault "gtk2";
    style.name = lib.mkDefault "gtk2";
  };


  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets = {
      fcitx5.enable = true;
      spicetify.enable = true;
      hyprpaper.enable = true;
      waybar.enable = true;
      hyprlock.enable = true;
      gedit.enable = true;
      firefox.enable = true;
      gtk.enable = true;
      gtk.flatpakSupport.enable = true;
    };
  };
}
