{ pkgs, ... }:
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 5;
        extraEntries = ''
          menuentry "Windows" {
              search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
              chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernelPackages =
      pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    consoleLogLevel = 0;
  };
}
