{inputs, username, host, ...}: {
  imports =
       [(import ./tmux.nix)]
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./btop.nix)]                      # resouces monitor 
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./zsh.nix)];                      # shell
}
