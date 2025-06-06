{ config, ... }:
let
  username = config.var.username;
in
{
  services.dbus.enable = true;
  # WSL 特定配置
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "${username}";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };
}
