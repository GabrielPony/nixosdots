{ inputs, uconfig, host, pkgs, ... }: {
imports = [
  ./tmux.nix
  ./nvim.nix                   # neovim editor
  ./btop.nix                   # resouces monitor
  ./git.nix                    # version control
  ./zsh.nix                    # shell
];
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
}
