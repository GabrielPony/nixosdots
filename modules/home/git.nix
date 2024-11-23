{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "GabrielPony";
    userEmail = "aoengo@outlook.com";

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
