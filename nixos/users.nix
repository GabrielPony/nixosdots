{ config, pkgs, ... }:
let
  username = config.var.username;
  password = config.var.password;
in
{
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      uid = 1000;
      isNormalUser = true;
      home = "/home/${username}";
      description = "${username} account";
      initialPassword = "${password}";
      extraGroups = [ "networkmanager" "wheel" ];

    };
  };
}
