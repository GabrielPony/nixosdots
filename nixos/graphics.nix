{ pkgs, config, ... }:
let
  username = config.var.username;
in
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
  hardware.enableRedistributableFirmware = true;
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us,fr";
      };

      displayManager.autoLogin = {
        enable = true;
        user = "${username}";
      };

      libinput = {
        enable = true;
        # mouse = {
        #   accelProfile = "flat";
        # };
      };

      # 以下是可选的图形界面相关服务
      # dbus.enable = true;
      # gvfs.enable = true;
      # upower.enable = true;
      # power-profiles-daemon.enable = true;
      # udisks2.enable = true;
    };

    # 图形界面相关程序
    programs.dconf.enable = true;

    # 如果需要在图形化配置中也包含基本包，可以添加：
    # environment.systemPackages = with pkgs; [
    #   # 图形相关包
    # ];

}
