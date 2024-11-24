{ pkgs, ... }:
let
  _wechat = pkgs.wechat-uos.overrideAttrs (oldAttrs: {
    postInstall = ''
      ${oldAttrs.postInstall or ""}

      # 完全覆盖原有的 desktop 文件
      cat > $out/share/applications/com.tencent.wechat.desktop << EOF
      [Desktop Entry]
      Name=WeChat
      Name[zh_CN]=微信
      Comment=WeChat Client
      Comment[zh_CN]=微信客户端
      GenericName=WeChat Client
      GenericName[zh_CN]=微信客户端
      Exec=$out/bin/wechat-uos --enable-features=UseOzonePlatform --ozone-platform=wayland -- %U
      StartupNotify=true
      Icon=com.tencent.wechat
      Type=Application
      Categories=Utility;
      Terminal=false
      StartupWMClass=wechat-uos
      EOF
    '';
  });
in
{
  home.packages = [ _wechat ];
}
