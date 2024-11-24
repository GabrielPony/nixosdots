{ pkgs, inputs, username, host, ... }:
let
  hostConfig = {
    "desktop" = [ ./../home/default.desktop.nix ];
    "laptop" = [ ./../home/default.desktop.nix ];
    "wsl" = [ ./../home/default.mini.nix ];
  }.${host} or [ ./../home ];
in
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "gabriel" ]; # 确保你的用户在这里
      allowed-users = [ "@wheel" "@nixbld" ];
      substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    };
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = hostConfig;
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  environment.profiles = [
    "$HOME/.nix-profile"
    "/etc/profiles/per-user/${username}"
  ];
  users.users.${username} = {
    uid = 1000;
    isNormalUser = true;
    initialPassword = "1111";
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys = [];

    # 配置用户的 SSH 目录和密钥
    # packages = [ pkgs.openssh ];
    # openssh.authorizedKeys.keyFiles = [ ./ssh/authorized_keys ];  # 如果有授权密钥文件
  };

}
