# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
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
  nixpkgs = {
  # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
  users.users = {
    # FIXME: Replace with your username
    gabriel = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "1111";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
    };
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces.eno1.ipv4.addresses = [{
      address = "192.168.7.59";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.7.3";
    nameservers = [ "114.114.114.114" "8.8.8.8" ];
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  services.displayManager.sddm.enable = true;
  services.xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
  };

  
  environment.systemPackages = with pkgs; [
      vim git wget curl vscode firefox
  ];
  environment.variables.EDITOR = "vim";
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  
  system.stateVersion = "24.05";
}

