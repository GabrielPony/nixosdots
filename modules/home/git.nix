{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "GabrielPony";
    userEmail = "aoengo@outlook.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
