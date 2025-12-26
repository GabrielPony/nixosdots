{ inputs, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      proc_tree = true;
      vim_keys = true;
      show_battery = true;
      check_temp = true;
    };
  };
}
