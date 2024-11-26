{ inputs, lib, system, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.pia.nixosModules."x86_64-linux".default
    ./../../nixos/variables.nix
    ./addon-configuration.nix
    ./hardware-configuration.nix
    ./../../modules/core/default.desktop.nix
  ];

  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  powerManagement.cpuFreqGovernor = "performance";
}
