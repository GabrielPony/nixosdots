{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-pinyin-zhwiki
      librime
      fcitx5-rime
      fcitx5-nord          # Nord 主题
      fcitx5-gtk
      fcitx5-chinese-addons
    ];
  };
  environment.etc = {
    # 经典界面配置
    "xdg/fcitx5/conf/classicui.conf".text = ''
      # 垂直候选列表
      Vertical Candidate List=False

      # 按屏幕 DPI 使用
      PerScreenDPI=True

      # 字体
      Font="Noto Sans CJK SC 10"

      # 主题 (选择一个，取消注释)
      # Theme=Material-Color-Blue
      Theme=Nord-Dark
      # Theme=breeze

      # 深色模式
      UseDarkTheme=True

      # 在 X11 上针对不同屏幕使用不同的 DPI
      PerScreenDPI=True
    '';

    # 拼音配置
    "xdg/fcitx5/conf/pinyin.conf".text = ''
      # 候选词数量
      PageSize=7

      # 启用云拼音
      CloudPinyinEnabled=True

      # 在程序中显示预编辑文本
      PreeditInApplication=True

      # 显示当前输入的字符
      ShowPreedit=True
    '';

    # 快捷键配置
    "xdg/fcitx5/config".text = ''
      [Hotkey]
      # 切换输入法
      TriggerKeys=Alt+space

      # 上一页
      PrevPage=minus

      # 下一页
      NextPage=equal

      # 切换全角/半角
      TogglePreedit=
    '';

    # Rime 配置（如果你使用 Rime）
    "xdg/fcitx5/conf/rime.conf".text = ''
      # 同步设置
      PreeditInApplication=True

      # 候选词数量
      PageSize=7
    '';
  };
}
