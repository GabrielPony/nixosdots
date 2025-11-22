{ pkgs, config, ... }:
let
  inherit (config.var.github) name email;
in
{
  programs.git = {
    enable = true;

    settings = {
      user={
        name = name;
        email = email;
      };

      core = {
          editor = "nvim";
        };
        init.defaultBranch = "main";
        credential.helper = "store";
      };
    };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
