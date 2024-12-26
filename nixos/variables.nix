{ config, ... }: {
  imports = [ ./variables-config.nix ];

  config.var = {
    version = "24.05";

    hsystem = "x86_64-linux";
    hostname = "nixos";
    username = "gabriel";
    password = "1111";

    # The path of the nixos configuration directory
    configDirectory = "/home/" + config.var.username + "/.config/nixos";
    keyboardLayout = "us";
    location = "Beijing";
    timeZone = "Asia/Shanghai";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "zh_CN.UTF-8";

    autoUpgrade = false;
    autoGarbageCollector = false;

    network = {
      gateway = "192.168.7.3";
      nameservers = [ "114.114.114.114" "8.8.8.8" ];
      tcpPorts = [ 22 80 443 2049 59010 59011 ];
      udpPorts = [ 2049 59010 59011 ];
    };

    # Choose your theme variables here
    # theme-name = "FlatColor";
    theme-name = "adw-gtk3";
    # theme = import ../../themes/var/pinky.nix;
  };
  config.user = {
    git = {
      username = "Kony";
      email = "aoengo@outlook.com";
    };
    custom = {
      repo = {
        owner = "GabrielPony"; # 替换为你的 GitHub 用户名
        name = "dotfiles"; # 替换为你的仓库名
        rev = "main"; # 可以是分支名、tag 或 commit hash
        sha256 = "sha256-2kIgjBvz14tfO+U27hu450Fe7Oi5uxum9kUyisxQT1U=";
      };
    };
  };
}
