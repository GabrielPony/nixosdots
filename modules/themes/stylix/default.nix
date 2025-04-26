{ inputs, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors-white";
      size = 24;
    };
    # iconTheme = {
    #   package = pkgs.papirus-icon-theme.override { color = "indigo"; };
    #   dark = "Papirus-Dark"; # used
    #   light = "Papirus-Light"; # unused
    # };
    fonts = {
      # monospace = {
      #   package = pkgs.nerdfonts.override { fonts = [ "Monaspace" ]; };
      #   name = "Monospice Nerd Font";
      # };
      # sansSerif = {
      #   package = pkgs.dejavu_fonts;
      #   name = "DejaVu Sans";
      # };
      # serif = {
      #   package = pkgs.dejavu_fonts;
      #   name = "DejaVu Serif";
      # };
      # sizes = {
      #   applications = 11;
      #   terminal = 12;
      #   desktop = 11;
      #   popups = 11;
      # };
      monospace = {
        package = pkgs.nerd-fonts.monaspace;
        name = "Monospice Nerd Font"; # 使用 Neon 变体
      };
      sansSerif = {
        # 改为更现代的字体组合
        package = pkgs.source-sans; # 或保持 dejavu_fonts
        name = "Source Sans"; # 或保持 "DejaVu Sans"
      };
      serif = {
        package = pkgs.source-serif; # 或保持 dejavu_fonts
        name = "Source Serif"; # 或保持 "DejaVu Serif"
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
        useWallpaper = true;
      };
      gnome.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
    };

    image = inputs.nixy-wallpapers + "/wallpapers/cat-leaves.png";
  };
}
