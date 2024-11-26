{ config, self, pkgs, lib, inputs, ...}:
let
  timeZone = config.var.timeZone;
  defaultLocale = config.var.defaultLocale;
  version = config.var.version;
in
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [  "https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    vim
  ];

  time.timeZone = "${timeZone}";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "${defaultLocale}";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "${version}";
}
