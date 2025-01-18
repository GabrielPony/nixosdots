{ pkgs, config, ... }:
let
  username = config.var.username;
in
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us,fr";
    };

    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
  };

  environment.profiles = [
    "$HOME/.nix-profile"
    "/etc/profiles/per-user/${username}"
  ];

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  # services.libinput.enable = true;
  programs.dconf.enable = true;
  # services = {
  #   dbus.enable = true;
  #   gvfs.enable = true;
  #   upower.enable = true;
  #   power-profiles-daemon.enable = true;
  #   udisks2.enable = true;
  # };
  #
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
    xdg-utils
    wget
    curl
  ];

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}


