{ pkgs, config, ... }:
let
  hostname = config.var.hostname;
  gateway = config.var.network.gateway;
  nameservers = config.var.network.nameservers;
  allowedTCPPorts = config.var.network.tcpPorts;
  allowedUDPPorts = config.var.network.udpPorts;
in
{
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    defaultGateway = gateway;
    nameservers = nameservers;
    firewall = {
      enable = true;
      allowedTCPPorts = allowedTCPPorts;
      allowedUDPPorts = allowedUDPPorts;
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}

