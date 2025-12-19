{ pkgs, inputs, nixpkgs, self, config, host, ... }:
let
  username = config.var.username;
in
{
  networking = {
    interfaces.enp2s0.useDHCP = true;
    # interfaces.enp2s0.ipv4.addresses = [{
    #   address = "192.168.7.60";
    #   prefixLength = 24;
    # }];
    interfaces.wlo1.ipv4.addresses = [{
      address = "192.168.7.61";
      prefixLength = 24;
    }];
  };

  home-manager.users."${username}" = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          "DP-2, 3840x2160@59.98, 0x0, 1"
          "eDP-1, 2880x1800@90, 3840x0, 1"
        ];

        bindl = [
          # ", switch:[switch name], exec, swaylock"
          ", switch:on:Lid Switch, exec, hyprctl keyword monitor 'eDP-1, disable'"
          ", switch:off:Lid Switch, exec, hyprctl keyword monitor 'eDP-1, 2880x1800@90, 3840x0, 1'"
        ];
      };
    };
  };
}
