{ pkgs, ... }:
let
  wechatDesktop = pkgs.makeDesktopItem {
    name = "com.tencent.wechat"; # 这会生成 com.tencent.wechat.desktop
    desktopName = "WeChat";
    genericName = "WeChat Client";
    exec = "${pkgs.wechat-uos}/bin/wechat-uos --enable-features=UseOzonePlatform --ozone-platform=wayland -- %U";
    icon = "com.tencent.wechat";
    comment = "WeChat Client";
    categories = [ "Utility" ];
    terminal = false;
    startupNotify = true;
    startupWMClass = "wechat-uos";
  };

  _wechat = pkgs.symlinkJoin {
    name = "wechat-uos";
    paths = [ pkgs.wechat-uos ];
    postBuild = ''
      rm $out/share/applications/com.tencent.wechat.desktop
      cp ${wechatDesktop}/share/applications/* $out/share/applications/
    '';
  };
in
{
  home.packages = [ _wechat ];
}
