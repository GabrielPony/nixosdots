{ pkgs, inputs, nixpkgs, self, username, host,lib, ... }: 
{
  services.dbus.enable = true;
  # WSL 特定配置
  wsl = {
    enable = true;
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = username;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };
}