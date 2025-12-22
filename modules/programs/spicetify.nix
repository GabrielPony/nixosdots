{ pkgs, config, lib, inputs, ... }:
let
  flavor = config.var.catppuccin.flavor;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      shuffle
      adblock
      fullAppDisplay
    ];
  };
}

