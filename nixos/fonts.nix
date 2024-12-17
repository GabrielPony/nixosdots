{ pkgs, inputs, ... }: {

  fonts = {
    packages = with pkgs; [
      source-sans
      source-serif
      source-code-pro
      wqy_zenhei
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      monaspace
      jetbrains-mono
      (nerdfonts.override { fonts = [ "Monaspace" "JetBrainsMono" "Noto" ]; })
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        serif = [
          "Source Serif"
          "Times New Roman"
          "Noto Serif"
          "Noto Serif CJK SC"
        ];

        sansSerif = [
          "Arial"
          "Source Sans"
          "Noto Sans"
          "Noto Sans CJK SC"
        ];

        monospace = [
          "Monaspace Argon"
          "MonaspiceAr Nerd Font" # Neon 变体的 Nerd Font 版本
          # 其他变体的 Nerd Font 版本：
          # "MonaspiceAr Nerd Font"   # Argon
          # "MonaspiceXe Nerd Font"   # Xenon
          # "MonaspiceRn Nerd Font"   # Radon
          # "MonaspiceKr Nerd Font"   # Krypton
          "Source Code Pro"
          "Noto Sans Mono"
          "Noto Sans Mono CJK SC"
        ];

        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
