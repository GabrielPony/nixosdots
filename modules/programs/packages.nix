{ inputs, pkgs, ... }:
let
  _2048 = pkgs.callPackage ../../pkgs/2048/default.nix { };
  _stm32cubemx = pkgs.callPackage ../../pkgs/stm32cubemx/default.nix { }; # for specific stm32cubemx version
in
{
  home.packages = (with pkgs; [
    _2048
    wkhtmltopdf
    aseprite
    webkitgtk_4_1
    audacity
    bitwise # cli tool for bit / hex manipulation
    cbonsai
    evince # gnome pdf viewer
    eza # ls replacement
    entr # perform action when file change
    fd # find replacement
    file # Show file information
    fzf # fuzzy finder
    gtt # google translate TUI
    gifsicle # gif utility
    gimp
    gtrash # rm replacement, put deleted files in system trash
    hexdump
    jdk17 # java
    lazygit
    libreoffice
    nitch # systhem fetch util
    nix-prefetch-github
    pipes
    prismlauncher # minecraft launcher
    ripgrep # grep replacement
    soundwireserver # pass audio to android phone
    toipe # typing test in the terminal
    valgrind # c memory analyzer
    yazi # terminal file manager
    yt-dlp-light
    zenity
    winetricks
    wineWowPackages.wayland
    qq
    rustdesk-flutter
    feishu
    usbutils
    meld
    # orca-slicer
    vlc
    scrcpy
    motrix
    telegram-desktop
    xfce.thunar
    todesk

    # Emedd
    stlink
    openocd
    inetutils
    gcc-arm-embedded-9
    jetbrains.clion
    _stm32cubemx
    minicom
    rkdeveloptool
    rkflashtool
    android-tools

    # C / C++
    gcc
    gnumake
    cmake

    # Python
    python3

    bleachbit # cache cleaner
    cmatrix
    gparted # partition manager
    ffmpeg
    imv # image viewer
    killall
    libnotify
    man-pages # extra man pages
    mpv # video player
    ncdu # disk space
    openssl
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume controle (GUI)
    playerctl # controller for media players
    wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
    cliphist # clipboard manager
    poweralertd
    qalculate-gtk # calculator
    unzip
    wget
    xdg-utils
    xxd
    inputs.alejandra.defaultPackage.${system}
  ]);
  home.file.".local/share/applications/STM32CubeMX.desktop".source =
    "${_stm32cubemx}/share/applications/STM32CubeMX.desktop";
}
