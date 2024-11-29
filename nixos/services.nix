{ ... }:
{
  services = {
    gvfs.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
    timesyncd = {
        enable = true;
        servers = [
        "ntp.aliyun.com"
        "ntp1.aliyun.com"
        "ntp.tencent.com"    # 腾讯 NTP 服务器
        "ntp.ubuntu.com"     # Ubuntu NTP 服务器
        "time.windows.com"   # Windows 时间服务器
        ];
     };
  };
  services.udev.extraRules=''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3744", MODE="0666"
  '';
}
