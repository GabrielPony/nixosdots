{ pkgs, ... }:
let
  ozoneDesktop = pkgs.makeDesktopItem {
    name = "segger-ozone"; # 这会生成 com.tencent.wechat.desktop
    desktopName = "Ozone";
    genericName = "Segger Ozone";
    exec = "${pkgs.segger-ozone}/bin/Ozone --enable-features=UseOzonePlatform --ozone-platform=wayland -- %U";
    icon = "segger-ozone";
    comment = "Segger Ozone";
    categories = [ "Utility" "GTK" ];
    terminal = false;
    startupNotify = true;
    startupWMClass = "segger-ozone";
  };

  _ozone = pkgs.symlinkJoin {
    name = "segger-ozone";
    paths = [ pkgs.segger-ozone ];
    postBuild = ''
      rm $out/share/applications/segger-ozone.desktop
      cp ${ozoneDesktop}/share/applications/* $out/share/applications/
    '';
  };
in
{
  home.packages = [ _ozone ];
}
