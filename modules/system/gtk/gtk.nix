{ config, pkgs, lib, ... }:
let
  # flavor = config.var.catppuccin.flavor;
  # accent = config.var.catppuccin.basic-accent;
  colors = config.var.colorScheme.palette;
  theme-name = config.var.theme-name;

in
{
  gtk = {
    enable = true;
    theme = {
      name = theme-name;
      package = pkgs."${theme-name}";
    };

    gtk3.extraCss = ''
      @define-color accent_color #${colors.base0D};
      @define-color accent_bg_color #${colors.base0D};
      @define-color accent_fg_color #${colors.base00};

      @define-color window_bg_color #${colors.base00};
      @define-color window_fg_color #${colors.base05};

      @define-color headerbar_bg_color #${colors.base00};
      @define-color headerbar_fg_color #${colors.base05};

      @define-color popover_bg_color #${colors.base00};
      @define-color popover_fg_color #${colors.base05};

      @define-color view_bg_color #${colors.base00};
      @define-color view_fg_color #${colors.base05};

      @define-color card_bg_color #${colors.base01};
      @define-color card_fg_color #${colors.base05};
    '';

    # GTK4 / Libadwaita 同理
    gtk4.extraCss = ''
      @define-color accent_color #${colors.base0D};
      @define-color accent_bg_color #${colors.base0D};
      @define-color accent_fg_color #${colors.base00};

      @define-color window_bg_color #${colors.base00};
      @define-color window_fg_color #${colors.base05};

      /* Libadwaita 特有的变量，确保彻底变色 */
      @define-color view_bg_color #${colors.base00};
      @define-color view_fg_color #${colors.base05};
    '';
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
