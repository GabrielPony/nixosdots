{ pkgs, inputs, nixpkgs, self, config, host, ... }:
let
  username = config.var.username;
in
{
  networking = {
    interfaces.eno1.ipv4.addresses = [{
      address = "192.168.7.62";
      prefixLength = 24;
    }];
  };
}
