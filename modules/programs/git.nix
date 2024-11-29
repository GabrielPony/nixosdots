{ pkgs, config, ... }:
let
  inherit (config.user.git) username email;
in
{
  programs.git = {
    enable = true;

    userName = username;
    userEmail = email;

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
