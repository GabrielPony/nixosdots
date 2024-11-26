{ config, ... }: {
  imports = [ ./variables-config.nix ];

  config.var = {
    version = "24.05";

    # system = "x86_64-linux";
    hostname = "nixos";
    username = "gabriel";
    password = "1111";

    # The path of the nixos configuration directory
    configDirectory = "/home/" + config.var.username + "/.config/nixos";
    # keyboardLayout = "fr";
    location = "Paris";
    timeZone = "Asian/Shanghai";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_FR.UTF-8";

    autoUpgrade = false;
    autoGarbageCollector = false;

    # Choose your theme variables here
    theme = import ../../themes/var/pinky.nix;
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
        sha256 = "sha256-K9A443WOXdonzSLxXYwztrVJA3kOtPirMMuS4MzFtP0=";
      };
    };
  };
}
