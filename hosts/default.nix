{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  myvars,
  mylib,
  system,
  ...
} @ args: let
#   name = "ai";
  base-modules = {
    common-modules = map mylib.relativeToRoot [
      # common
    #   "secrets/nixos.nix"
    #   "modules/nixos/desktop.nix"
    #   # host specific
    #   "hosts/idols-${name}"
        
        "./../../../modules/core"
    ];
    laptop-modules = map mylib.relativeToRoot [
        "./hardware-configuration.nix"
    ];
    desktop-modules = map mylib.relativeToRoot [
        "./hardware-configuration.nix"
    ];
  };

    modules-desktop = {
        nixos-modules =
            [
                {
                modules.desktop.custom.enable = true;
                }
            ]
            ++ base-modules.nixos-modules
            ++ desktop-modules.nixos-modules;
    };

    modules-laptop = {
        nixos-modules =
            [
                {
                modules.laptop.custom.enable = true;
                }
            ]
            ++ base-modules.nixos-modules
            ++ laptop-modules.nixos-modules;
    };
in {
    powerManagement.cpuFreqGovernor = "performance";
    nixosConfigurations = {
    # with i3 window manager
        desktop = envlib.nixosSystem (modules-desktop // args);
        # host with hyprland compositor
        laptop = envlib.nixosSystem (modules-laptop // args);
  };

  # generate iso image for hosts with desktop environment
#   packages = {
#     "${name}-i3" = inputs.self.nixosConfigurations."${name}-i3".config.formats.iso;
#     "${name}-hyprland" = inputs.self.nixosConfigurations."${name}-hyprland".config.formats.iso;
#   };
}
