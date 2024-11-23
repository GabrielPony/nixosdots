{ inputs, username, host, pkgs, ... }: {
  home.packages = (with pkgs; [
    dos2unix
    gcc
    unzip
    bear
    python3
    pipx
    lua
    clang-tools
  ]);
  imports =
    [ (import ./tmux.nix) ]
    ++ [ (import ./nvim.nix) ]                      # neovim editor
    ++ [ (import ./btop.nix) ]                      # resouces monitor
    ++ [ (import ./git.nix) ]                       # version control
    ++ [ (import ./zsh.nix) ]; # shell
}
