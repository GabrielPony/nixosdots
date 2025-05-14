{ config, inputs, ... }: {
  imports = [
    # modules
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nur.modules.nixos.default

    ./addon-configuration.nix
    ./hardware-configuration.nix
    ./../../nixos/variables.nix

    # nixos
    ../../nixos/base.nix
    ../../nixos/bootloader.nix
    ../../nixos/users.nix
    ../../nixos/services.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/docker.nix
    ../../nixos/security.nix
    ../../nixos/timezone.nix
    ../../nixos/variables-config.nix

    # Choose your theme here
    ../../modules/themes/stylix/default.nix
    ];


  home-manager.users."${config.var.username}" = import ../../modules/default.mini.nix;

  # Don't touch this
  # nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  nix.settings = {
    access-tokens = "github.com=";
  };
  system.stateVersion = "24.05";
  powerManagement.cpuFreqGovernor = "performance";
}
