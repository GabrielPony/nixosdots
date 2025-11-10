{ config, pkgs, ... }:

{
  services.kasmweb = {
    enable = true;
    listenPort = 3030;
  };
}
