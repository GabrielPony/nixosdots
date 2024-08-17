{ ... }: 
{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
    };
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
  services.udev.extraRules=''
    USBSYSTEM=="usb",ATTR{idVendor}=="0483",ATTR{idProduct}=="374b",GROUP="gabriel",MODE="0666"
    USBSYSTEM=="usb",ATTR{idVendor}=="0483",ATTR{idProduct}=="3748",GROUP="gabriel",MODE="0666"
    USBSYSTEM=="usb",ATTR{idVendor}=="0483",ATTR{idProduct}=="3744",GROUP="gabriel",MODE="0666"
  '';
}
