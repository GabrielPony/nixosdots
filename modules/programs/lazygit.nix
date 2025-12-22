{ config, lib, ... }:
let
in {
  programs.lazygit = {
    enable = true;
    settings = lib.mkForce {
      gui = {
        showListFooter = false;
        showRandomTip = false;
        showCommandLog = false;
        showBottomLine = false;
        nerdFontsVersion = "3";
      };
    };
  };
}
