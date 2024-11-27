{ pkgs, inputs, lib, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.pia.nixosModules.${pkgs.system}.default
    ./../../nixos/variables.nix
    ./addon-configuration.nix
    ./hardware-configuration.nix
    ./../../modules/core/default.desktop.nix
  ];

  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  powerManagement.cpuFreqGovernor = "performance";
}
