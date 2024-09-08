{ pkgs, ... }:
{  
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        amdvlk 
      ];
    };
  };
  hardware.enableRedistributableFirmware = true;
}
