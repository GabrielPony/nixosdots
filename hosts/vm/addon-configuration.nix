{ pkgs, inputs, nixpkgs, self, config, host, ... }:
let
  username = config.var.username;
in
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";  # 直接指定磁盘设备，如 /dev/sda
        efiSupport = false;   # 禁用 EFI 支持
        configurationLimit = 5;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.
    consoleLogLevel = 0;
  };
  networking = {
    interfaces.ens18.ipv4.addresses = [{
      address = "192.168.7.12";
      prefixLength = 24;
    }];
  };
}
