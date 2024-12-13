{ config, inputs, ... }: {
  imports = [
    # modules
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.wsl
    inputs.pia.nixosModules.${pkgs.system}.default
    inputs.nur.nixosModules.nur
    ./addon-configuration.nix
    ./../../nixos/variables.nix

    # nixos
    ../../nixos/utils.nix
    ../../nixos/users.nix
    ../../nixos/services.nix
    ../../nixos/home-manager.nix
    ../../nixos/network.nix
    ../../nixos/nix.nix
    ../../nixos/security.nix
    ../../nixos/timezone.nix
    ../../nixos/variables-config.nix
    ../../nixos/virtualization.nix

    # Choose your theme here
    ../../modules/themes/stylix/default.nix
    ];


  home-manager.users."${config.var.username}" = import ../../modules/default.mini.nix;

  # Don't touch this
  # nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  system.stateVersion = "24.05";
  powerManagement.cpuFreqGovernor = "performance";
}
