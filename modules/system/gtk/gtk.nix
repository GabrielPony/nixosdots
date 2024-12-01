{ pkgs, config, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
  ];

  gtk = {
    enable = true;
    # font = {
    #   name = "JetBrainsMono Nerd Font";
    #   size = 11;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
      # package = pkgs.catppuccin-gtk.override {
      #   accents = [ "lavender" ]; # 与你的图标主题accent保持一致
      #   variant = "mocha"; # 使用 mocha 变体
      # };
    };
  };

}
