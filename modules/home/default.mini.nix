{inputs, username, host, pkgs, ...}: {
  imports =
       [(import ./tmux.nix)]
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./btop.nix)]                      # resouces monitor 
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./zsh.nix)];                      # shell
    home.packages = (with pkgs; [
    dos2unix
    ]);
}
