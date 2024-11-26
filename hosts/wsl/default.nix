{ inputs, lib, ... }:
{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl.nixosModules.wsl
    ./../../nixos/variables.nix
    ./addon-configuration.nix
    ./../../modules/core/default.mini.nix
  ];

  nix.nixPath = lib.mkForce [ "/etc/nix/inputs" ];
}
