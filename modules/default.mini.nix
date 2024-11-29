{ inputs, nixpkgs, self, config, host, ...}:
{
  imports =
       [ (import ./program.nix) ]
    ++ [ (import ./services.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./security.nix) ]
    ++ [ (import ./user.nix) ];
}
