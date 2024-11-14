{ inputs, nixpkgs, self, username, host, ...}:
{
  imports =
       [ (import ./program.nix) ]
    ++ [ (import ./services.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ];
}