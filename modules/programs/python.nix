{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    python312
    python312Packages.virtualenv
    python312Packages.debugpy
    python312Packages.pip
  ];
}
