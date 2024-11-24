{ inputs, username, host, ... }: {
  imports = [
    ./default.nix
    ./wechat.nix
    ./rider.nix # C# JetBrain editor
    ./fcitx.nix
    ./gedit.nix
  ];
  # ++ [(import ./steam.nix)];
  # ++ [(import ./unity.nix)];
}
