# Gabriel's NixOS Configuration


## build nixos
```
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#wsl
```


## Net Set 

sudo ip route del default
sudo ip route add default via 192.168.7.3 dev eth0