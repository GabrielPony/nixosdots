{
    nixpkgs,
    self,
    ...
} @ inputs: let
    # inherit (inputs.nixpkgs) lib;
    # lib = nixpkgs.lib;
    # envlib = import ../libs {inherit lib;};
    selfPkgs = import ../pkgs;
    username = "gabriel";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

    # args = {inherit nixpkgs self username inputs lib envlib;};
in{
    overlays.default = selfPkgs.overlay;
    nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ (import ../hosts) ];
            specialArgs = { host="desktop"; inherit nixpkgs self username inputs lib ; };
        };
        laptop = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ (import ../hosts) ];
            specialArgs = { host="laptop"; inherit nixpkgs self username inputs lib ; };
        };
    };
}