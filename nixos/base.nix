{ pkgs, config, ... }:
let
  username = config.var.username;
in
{
  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
  };

  environment.profiles = [
    "$HOME/.nix-profile"
    "/etc/profiles/per-user/${username}"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };

  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    fd
    bc
    gcc
    vim
    git
    git-ignore
    wget
    curl
    pkgsi686Linux.glibc
    pkgsi686Linux.gcc
  ];

  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
      HandlePowerKey = "ignore";
    };
  };
}
