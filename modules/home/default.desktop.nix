{ inputs, username, host, ... }: {
  imports = [
    ./default.nix
    ./wechat.nix
    ./rider.nix # C# JetBrain editor
  ];
  # ++ [(import ./steam.nix)];
  # ++ [(import ./unity.nix)];
}
