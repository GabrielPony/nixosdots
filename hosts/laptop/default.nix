{ pkgs, lib, ... }: 
{
  imports = [
    ./addon-configuration.nix
    ./hardware-configuration.nix
    ./../../modules/core/default.desktop.nix
  ];

  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  powerManagement.cpuFreqGovernor = "performance";
}
