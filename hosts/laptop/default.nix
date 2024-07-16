{ pkgs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  powerManagement.cpuFreqGovernor = "performance";
}
