{ pkgs, ... }:
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


  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets = {
      spicetify.enable = true;
      hyprpaper.enable = true;
      hyprlock.enable = true;
      gedit.enable = true;
      firefox.enable = true;
      gtk.enable = true;
    };
  };
}
