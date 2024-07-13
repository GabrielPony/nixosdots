{ pkgs, ... }: 
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces.eno1.ipv4.addresses = [{
      address = "192.168.7.59";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.7.3";
    nameservers = [ "114.114.114.114" "8.8.8.8" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 59010 59011 ];
      allowedUDPPorts = [ 59010 59011 ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
